Return-Path: <linux-kernel+bounces-58871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7392184EDF3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52002B302A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5C156761;
	Thu,  8 Feb 2024 23:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NpkV10KA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C37650A64;
	Thu,  8 Feb 2024 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435208; cv=none; b=u4XHtbkryxUu/2f+fRBDgby7YFe9cz4EPQxeUd25VLsI2dy6iu/Mxiqp7Jg13G+TfNXR2q/31K4sddYMC3HcUJ+ake3cDdM9QD4BNseRl7LI0yi3VVpHpsC1aGn5OMhAIbI6WvNlsswQzcVEqtCNrJ03EPOpe8kdSVz9TE7jsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435208; c=relaxed/simple;
	bh=TEEFEepXyCqc9g1ZZZ8XtBGqtWSrNLURh9dQCcX4rtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aUAr+X9qWAXLo429yrIR1I3tWyE3k3wBAi7nmbXVDOa4V5q3SNFy4lkrYi/dF5skb2XLvObth3tnKIdSXpZI08Nbhn7OISNPkOz7qlIiLSazRCpZOx16kibJhaxOTWGCqfnWUOPvpbolXmZvDDOMbDc4Lag1JZkqCJV3fieAKAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NpkV10KA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418N0KNJ004992;
	Thu, 8 Feb 2024 23:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Oy7H7tCINrPN6qPXnahQy8morONvqh8KS+VwLuVeV84=; b=Np
	kV10KAlmmljAfdNpISR2CmPE/sLh2AsZxblIrCFU16RfXzw/vYIEhsEcyHr4LQjJ
	ta9mAuTg1/yx508yNHRLtDCiTvnchFrgaI/MUgeF/FkQBOjq/gSg0rWLsQyvxWOv
	7zpnbrKHFK2vrqNNPPMUePu0Wf/MeTMqOx96VTI694gYIvOajZQZYPsjJN6PhJCY
	rL9FhXVtrzwsvoTxEwb/A52CORBdnn08/hAp4z88omGKtsH2ewznUUTwC2d3gaWj
	5PjptBJJ6EpWV2q8o8YhNFbnbqPOHK1rz48RUatQzCBlNy3YzvH7CE+FOyp7fVnt
	fFpF36B7LJCiuERnI7ZQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4hhkbbs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:33:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418NX7xS012074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 23:33:07 GMT
Received: from [10.71.114.174] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 15:33:06 -0800
Message-ID: <852cc2e0-4e61-3b8a-428f-7623ceade463@quicinc.com>
Date: Thu, 8 Feb 2024 15:33:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v14 00/53] Introduce QC USB SND audio offloading support
Content-Language: en-US
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20240208231406.27397-1-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GfinuZM_oyq9rMZiW24z_n-NJyrjMlOs
X-Proofpoint-GUID: GfinuZM_oyq9rMZiW24z_n-NJyrjMlOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080134

Hi Mark/Takashi,

On 2/8/2024 3:13 PM, Wesley Cheng wrote:
<snip>

Would it be possible to see if we could start pulling some of these non 
offloading dependent changes into your repos?  It would really be 
helpful since the # of patches is getting a little cumbersome to 
maintain.  If we need to make any follow ups, I can address them as a 
separate patch and add it to the series w/ the other changes that are 
still pending.

> Mathias Nyman (13):
>    xhci: fix possible null pointer dereference at secondary interrupter
>      removal
>    xhci: fix off by one check when adding a secondary interrupter.
>    xhci: Add interrupt pending autoclear flag to each interrupter
>    xhci: Add helper to set an interrupters interrupt moderation interval
>    xhci: make isoc_bei_interval variable interrupter specific.
>    xhci: remove unnecessary event_ring_deq parameter from
>      xhci_handle_event()
>    xhci: update event ring dequeue pointer position to controller
>      correctly
>    xhci: move event processing for one interrupter to a separate function
>    xhci: add helper that checks for unhandled events on a event ring
>    xhci: Don't check if the event ring is valid before every event TRB
>    xhci: Decouple handling an event from checking for unhandled events
>    xhci: add helper to stop endpoint and wait for completion
>    xhci: sideband: add initial api to register a sideband entity
> 

Will work with Mathias on the XHCI stuff when he gets some time to 
review the set of changes added for the XHCI interrupters.  Some of the 
series in USB SND are dependent on that, such as the qc_audio_offload 
driver, since it makes calls into the XHCI sideband that was added, so 
won't be able to pull that in yet. (This is the only driver that will 
interact w/ XHCI sideband, all ASoC and general USB SND changes are 
independent)

Thanks
Wesley Cheng

> Wesley Cheng (40):
>    usb: host: xhci: Export enable and disable interrupter APIs
>    usb: host: xhci: Repurpose event handler for skipping interrupter
>      events
>    xhci: export XHCI IMOD setting helper for interrupters
>    usb: host: xhci-sideband: Expose a sideband interrupter enable API
>    usb: host: xhci-mem: Cleanup pending secondary event ring events
>    usb: host: xhci-mem: Allow for interrupter clients to choose specific
>      index
>    ASoC: Add SOC USB APIs for adding an USB backend
>    ASoC: dt-bindings: qcom,q6dsp-lpass-ports: Add USB_RX port
>    ASoC: qcom: qdsp6: Introduce USB AFE port to q6dsp
>    ASoC: qdsp6: q6afe: Increase APR timeout >    ASoC: qcom: qdsp6: Add USB backend ASoC driver for Q6>    ALSA: 
usb-audio: Introduce USB SND platform op callbacks
>    ALSA: usb-audio: Export USB SND APIs for modules
>    ALSA: usb-audio: Save UAC sample size information
>    usb: dwc3: Specify maximum number of XHCI interrupters
>    usb: host: xhci-plat: Set XHCI max interrupters if property is present
>    ALSA: usb-audio: qcom: Add USB QMI definitions
>    ALSA: usb-audio: qcom: Introduce QC USB SND offloading support
>    ALSA: usb-audio: Check for support for requested audio format
>    ASoC: usb: Add PCM format check API for USB backend
>    ASoC: qcom: qdsp6: Ensure PCM format is supported by USB audio device
>    ALSA: usb-audio: Prevent starting of audio stream if in use
>    ALSA: usb-audio: Do not allow USB offload path if PCM device is in use
>    ASoC: dt-bindings: Add Q6USB backend
>    ASoC: dt-bindings: Update example for enabling USB offload on SM8250
>    ALSA: usb-audio: qcom: Populate PCM and USB chip information
>    ASoC: qcom: qdsp6: Add support to track available USB PCM devices
>    ASoC: Introduce SND kcontrols to select sound card and PCM device
>    ASoC: qcom: qdsp6: Add SOC USB offload select get/put callbacks
>    ASoC: Add SND kcontrol for fetching USB offload status
>    ASoC: qcom: qdsp6: Add PCM ops to track current state
>    ASoC: usb: Create SOC USB SND jack kcontrol
>    ASoC: qcom: qdsp6: Add headphone jack for offload connection status
>    ASoC: usb: Fetch ASoC sound card information
>    ALSA: usb-audio: mixer: Add USB offloading mixer control
>    ALSA: usb-audio: qcom: Use card and PCM index from QMI request
>    ALSA: usb-audio: Allow for rediscovery of connected USB SND devices
>    ASoC: usb: Rediscover USB SND devices on USB port add
>    ASoC: qcom: Populate SoC components string
>    ASoC: doc: Add documentation for SOC USB
> 
>   .../devicetree/bindings/sound/qcom,q6usb.yaml |   55 +
>   .../bindings/sound/qcom,sm8250.yaml           |   15 +
>   Documentation/sound/soc/index.rst             |    1 +
>   Documentation/sound/soc/usb.rst               |  611 ++++++
>   drivers/usb/dwc3/core.c                       |   12 +
>   drivers/usb/dwc3/core.h                       |    2 +
>   drivers/usb/dwc3/host.c                       |    5 +-
>   drivers/usb/host/Kconfig                      |    9 +
>   drivers/usb/host/Makefile                     |    2 +
>   drivers/usb/host/xhci-mem.c                   |   53 +-
>   drivers/usb/host/xhci-plat.c                  |    2 +
>   drivers/usb/host/xhci-ring.c                  |  240 ++-
>   drivers/usb/host/xhci-sideband.c              |  439 ++++
>   drivers/usb/host/xhci.c                       |   97 +-
>   drivers/usb/host/xhci.h                       |   21 +-
>   .../sound/qcom,q6dsp-lpass-ports.h            |    1 +
>   include/linux/usb/xhci-sideband.h             |   70 +
>   include/sound/q6usboffload.h                  |   20 +
>   include/sound/soc-usb.h                       |   90 +
>   sound/soc/Makefile                            |    2 +-
>   sound/soc/qcom/Kconfig                        |    4 +
>   sound/soc/qcom/common.c                       |   41 +
>   sound/soc/qcom/common.h                       |    4 +-
>   sound/soc/qcom/qdsp6/Makefile                 |    1 +
>   sound/soc/qcom/qdsp6/q6afe-dai.c              |   60 +
>   sound/soc/qcom/qdsp6/q6afe.c                  |  193 +-
>   sound/soc/qcom/qdsp6/q6afe.h                  |   36 +-
>   sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c      |   23 +
>   sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h      |    1 +
>   sound/soc/qcom/qdsp6/q6routing.c              |    9 +
>   sound/soc/qcom/qdsp6/q6usb.c                  |  401 ++++
>   sound/soc/qcom/sm8250.c                       |   14 +-
>   sound/soc/soc-usb.c                           |  538 +++++
>   sound/usb/Kconfig                             |   19 +
>   sound/usb/Makefile                            |    3 +-
>   sound/usb/card.c                              |  109 +
>   sound/usb/card.h                              |   24 +
>   sound/usb/endpoint.c                          |    1 +
>   sound/usb/format.c                            |    1 +
>   sound/usb/helper.c                            |    1 +
>   sound/usb/mixer.c                             |    5 +
>   sound/usb/mixer_usb_offload.c                 |   72 +
>   sound/usb/mixer_usb_offload.h                 |   17 +
>   sound/usb/pcm.c                               |  104 +-
>   sound/usb/pcm.h                               |   11 +
>   sound/usb/qcom/Makefile                       |    2 +
>   sound/usb/qcom/qc_audio_offload.c             | 1910 +++++++++++++++++
>   sound/usb/qcom/usb_audio_qmi_v01.c            |  892 ++++++++
>   sound/usb/qcom/usb_audio_qmi_v01.h            |  162 ++
>   49 files changed, 6228 insertions(+), 177 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb.yaml
>   create mode 100644 Documentation/sound/soc/usb.rst
>   create mode 100644 drivers/usb/host/xhci-sideband.c
>   create mode 100644 include/linux/usb/xhci-sideband.h
>   create mode 100644 include/sound/q6usboffload.h
>   create mode 100644 include/sound/soc-usb.h
>   create mode 100644 sound/soc/qcom/qdsp6/q6usb.c
>   create mode 100644 sound/soc/soc-usb.c
>   create mode 100644 sound/usb/mixer_usb_offload.c
>   create mode 100644 sound/usb/mixer_usb_offload.h
>   create mode 100644 sound/usb/qcom/Makefile
>   create mode 100644 sound/usb/qcom/qc_audio_offload.c
>   create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.c
>   create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.h
> 

