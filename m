Return-Path: <linux-kernel+bounces-62818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4899485268E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF191C24CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45D66216E;
	Tue, 13 Feb 2024 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ql0SRIOj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8458124;
	Tue, 13 Feb 2024 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785710; cv=none; b=BCgmvKPLFX8sMNXdABlCMz7Qw2ikyxLo1ulUkoyuIDN3lqk2QWZQFZrmTW4Us5td5ivMhPYCXAuESHCqgT58UtsgqdSrqDQxqan/g7To3R8O3Pf3+r02dNkilgj/S07B6Bz9qNv64AvE5u4NMEO+LXqgpycKNUs8sAwkwB/pRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785710; c=relaxed/simple;
	bh=0vAv28oLwBq3NyS05zqdkV9YjAodSgvlpTngEkQv2OU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uZ2hfNsR/htn/Y6c86JFMcp6efkD71CQ7q7uOIqANhi1GhqW0o6J7bOovaFwZ5tAgzcVpsHdS0dzLqYV5Q2/o50oTKq5wQrLk6+d0lnIwApPr7/jD2WTztgO6BxTs5+It5X1l9M3XhGN54mWrz08Ql6RtFAFM+bxh5iBIa14DJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ql0SRIOj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CNm0Ze015949;
	Tue, 13 Feb 2024 00:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=yWZLMIL6n7hXwUHeDyHDlGGyr9fc8lWU6FYK3wS686s=; b=Ql
	0SRIOjnPzNsOwjxUl9rqSRiFdZQ+5JstGWgOgQGAvoPSkm+y0AiPy1B6RTFM6KOW
	9gj5qmqzk/jClZVrTvHsy5kSvG6tEXezNPqfNVE5Hxc95wKiTNKjk/3fq5+4Gr2K
	Y6sIivdgGdC0rKi6PjQe36CivsYIZCbeLOSLjaxb31F8UFLqJ29+FID4NtKCsxIF
	H4y+wSeNmV7sgJy/UVSEpFy+QGuAfr5/jnspiGjTjNy8j0MQcdXpxeiYvRkyX2zd
	tv+9aF2hmSocmyuZv/bzRkz1nVlcwdGyaTmtf+YUPA6sHLbSWJkYU9u7vAKYL9KD
	HsWU1Dzb8zxUKzwtS1eg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gvjhuwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:54:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D0sX16031052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:54:33 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 16:54:32 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
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
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v15 00/50] Introduce QC USB SND audio offloading support
Date: Mon, 12 Feb 2024 16:53:32 -0800
Message-ID: <20240213005422.3121-1-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GdQcsfxVIsJuRQU_kuafIrGJPFLAsFhR
X-Proofpoint-ORIG-GUID: GdQcsfxVIsJuRQU_kuafIrGJPFLAsFhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130004

Several Qualcomm based chipsets can support USB audio offloading to a
dedicated audio DSP, which can take over issuing transfers to the USB
host controller.  The intention is to reduce the load on the main
processors in the SoC, and allow them to be placed into lower power modes.
There are several parts to this design:
  1. Adding ASoC binding layer
  2. Create a USB backend for Q6DSP
  3. Introduce XHCI interrupter support
  4. Create vendor ops for the USB SND driver

      USB                          |            ASoC
--------------------------------------------------------------------
                                   |  _________________________
                                   | |sm8250 platform card     |
                                   | |_________________________|
                                   |         |           |
                                   |      ___V____   ____V____
                                   |     |Q6USB   | |Q6AFE    |  
                                   |     |"codec" | |"cpu"    |
                                   |     |________| |_________|
                                   |         ^  ^        ^
                                   |         |  |________|
                                   |      ___V____    |
                                   |     |SOC-USB |   |
   ________       ________               |        |   |
  |USB SND |<--->|QC offld|<------------>|________|   |
  |(card.c)|     |        |<----------                |
  |________|     |________|___     | |                |
      ^               ^       |    | |    ____________V_________
      |               |       |    | |   |APR/GLINK             |
   __ V_______________V_____  |    | |   |______________________|
  |USB SND (endpoint.c)     | |    | |              ^
  |_________________________| |    | |              |
              ^               |    | |   ___________V___________
              |               |    | |->|audio DSP              |
   ___________V_____________  |    |    |_______________________|
  |XHCI HCD                 |<-    |
  |_________________________|      |


Adding ASoC binding layer:
soc-usb: Intention is to treat a USB port similar to a headphone jack.
The port is always present on the device, but cable/pin status can be
enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
communicate with USB SND.

Create a USB backend for Q6DSP:
q6usb: Basic backend driver that will be responsible for maintaining the
resources needed to initiate a playback stream using the Q6DSP.  Will
be the entity that checks to make sure the connected USB audio device
supports the requested PCM format.  If it does not, the PCM open call will
fail, and userpsace ALSA can take action accordingly.

Introduce XHCI interrupter support:
XHCI HCD supports multiple interrupters, which allows for events to be routed
to different event rings.  This is determined by "Interrupter Target" field
specified in Section "6.4.1.1 Normal TRB" of the XHCI specification.

Events in the offloading case will be routed to an event ring that is assigned
to the audio DSP.

Create vendor ops for the USB SND driver:
qc_audio_offload: This particular driver has several components associated
with it:
- QMI stream request handler
- XHCI interrupter and resource management
- audio DSP memory management

When the audio DSP wants to enable a playback stream, the request is first
received by the ASoC platform sound card.  Depending on the selected route,
ASoC will bring up the individual DAIs in the path.  The Q6USB backend DAI
will send an AFE port start command (with enabling the USB playback path), and
the audio DSP will handle the request accordingly.

Part of the AFE USB port start handling will have an exchange of control
messages using the QMI protocol.  The qc_audio_offload driver will populate the
buffer information:
- Event ring base address
- EP transfer ring base address

and pass it along to the audio DSP.  All endpoint management will now be handed
over to the DSP, and the main processor is not involved in transfers.

Overall, implementing this feature will still expose separate sound card and PCM
devices for both the platorm card and USB audio device:
 0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
                      SM8250-MTP-WCD9380-WSA8810-VA-DMIC
 1 [Audio          ]: USB-Audio - USB Audio
                      Generic USB Audio at usb-xhci-hcd.1.auto-1.4, high speed

This is to ensure that userspace ALSA entities can decide which route to take
when executing the audio playback.  In the above, if card#1 is selected, then
USB audio data will take the legacy path over the USB PCM drivers, etc...

This feature was validated using:
- tinymix: set/enable the multimedia path to route to USB backend
- tinyplay: issue playback on platform card

Changelog
--------------------------------------------
Changes in v15:
- Removed some already merged XHCI changes
- Separated SOC USB driver from being always compiled into SOC core.  Now
  configurable from kconfig.
- Fixed up ASoC kcontrol naming to fit guidelines.
- Removed some unnecessary dummy ifdefs.
- Moved usb snd offload capable kcontrol to be initialized by the platform offloading
  driver.

Changes in v14:
- Cleaned up some USB SND related feedback:
  - Renamed SNDUSB OFFLD playback available --> USB offload capable card
  - Fixed locking while checking if stream is in use
  - Replaced some mutex pairs with guard(mutex)

Changes in v13:
- Pulled in secondary/primary interrupter rework from Mathias from:
  https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/drivers/usb/host?h=fix_eventhandling
  - Did some cleanup and commit message updates, and tested on current code base.
- Added mutex locking to xhci sideband to help prevent any race conditions, esp. for when accessing shared
  references.
- Addresed concerns from Hillf about gfp_flags and locking used in qc_usb_audio_offload.
- Rebased onto usb-next

Changes in v12:
- Updated copyright year to 2024.  Happy new years!
- Fixed newline format on mixer offload driver.

Changes in v11:
- Modified QMI format structures to be const

Changes in v10:
- Added new mixer for exposing kcontrol for sound card created by USB SND.  This
allows for applications to know which platform sound card has offload support.
Will return the card number.
- Broke down and cleaned up some functions/APIs within qc_audio_offload driver.
- Exported xhci_initialize_ring_info(), and modified XHCI makefile to allow for
the XHCI sideband to exist as a module.
- Reworked the jack registration and moved it to the QCOM platform card driver,
ie sm8250.
- Added an SOC USB API to fetch a standard component tag that can be appended to
the platform sound card.  Added this tag to sm8250 if any USB path exists within
the DT node.
- Moved kcontrols that existed in the Q6USB driver, and made it a bit more generic,
so that naming can be standardized across solutions.  SOC USB is now responsible
for creation of these kcontrols.
- Added a SOC USB RST document explaining some code flows and implementation details
so that other vendors can utilize the framework.
- Addressed a case where USB device connection events are lost if usb offload driver
(qc_audio_offload) is not probed when everything else has been initialized, ie 
USB SND, SOC USB and ASoC sound card.  Add a rediscover device call during module
init, to ensure that connection events will be propagated.
- Rebased to usb-next.

Changes in v9:
- Fixed the dt binding check issue with regards to num-hc-interrupters.

Changes in v8:
- Cleaned up snd_soc_usb_find_priv_data() based on Mark's feedback.  Removed some of
the duplicate looping code that was present on previous patches.  Also renamed the API.
- Integrated Mathias' suggestions on his new sideband changes:
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters
- Addressed some of Mathias' fixme tags, such as:
 - Resetting transfer ring dequeue/enqueue pointers
 - Issuing stop endpoint command during ep removal
 - Reset ERDP properly to first segment ring during interrupter removal. (this is currently
   just being cleared to 0, but should be pointing to a valid segment if controller is still
   running.

Changes in v7:
- Fixed dt check error for q6usb bindings
- Updated q6usb property from qcom,usb-audio-intr-num --> qcom,usb-audio-intr-idx
- Removed separate DWC3 HC interrupters num property, and place limits to XHCI one.
- Modified xhci_ring_to_sgtable() to use assigned IOVA/DMA address to fetch pages, as
it is not ensured event ring allocated is always done in the vmalloc range.

Changes in v6:
- Fixed limits and description on several DT bindings (XHCI and Q6USB)
- Fixed patch subjects to follow other ALSA/ASoC notations.

USB SND
- Addressed devices which expose multiple audio (UAC) interfaces.  These devices will
create a single USB sound card with multiple audio streams, and receive multiple
interface probe routines.  QC offload was not properly considering cases with multiple
probe calls.
- Renamed offload module name and kconfig to fit within the SND domain.
- Renamed attach/detach endpoint API to keep the hw_params notation.

Changes in v5:
- Removed some unnescessary files that were included
- Fixed some typos mentioned
- Addressed dt-binding issues and added hc-interrupters definition to usb-xhci.yaml

XHCI:
- Moved secondary skip events API to xhci-ring and updated implementation
   - Utilized existing XHCI APIs, such as inc_deq and xhci_update_erst_dequeue()

USB SND
- Renamed and reworked the APIs in "sound: usb: Export USB SND APIs for modules" patch to
include suggestions to utilize snd_usb_hw_params/free and to avoid generic naming.
- Added a resume_cb() op for completion sake.
- Addressed some locking concerns with regards to when registering for platform hooks.
- Added routine to disconnect all offloaded devices during module unbind.

ASoC
- Replaced individual PCM parameter arguments in snd_soc_usb_connect() with new
snd_soc_usb_device structure to pass along PCM info.
- Modified snd_jack set report to notify HEADPHONE event, as we do not support record path.

Changes in v4:
- Rebased to xhci/for-usb-next
- Addressed some dt-bindings comments

XHCI:
- Pulled in latest changes from Mathias' feature_interrupters branch:
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters

- Fixed commit text and signage for the XHCI sideband/interrupter related changes
- Added some logic to address the FIXME tags mentioned throughout the commits, such
as handling multi segment rings and building the SGT, locking concerns, and ep
cleanup operations.
- Removed some fixme tags for conditions that may not be needed/addressed.
- Repurposed the new endpoint stop sync API to be utilized in other places.
- Fixed potential compile issue if XHCI sideband config is not defined.

ASoC:
- Added sound jack control into the Q6USB driver.  Allows for userpsace to know when
an offload capable device is connected.

USB SND:
- Avoided exporting _snd_pcm_hw_param_set based on Takashi's recommendation.
- Split USB QMI packet header definitions into a separate commit.  This is used to
properly allow the QMI interface driver to parse and route QMI packets accordingly
- Added a "depends on" entry when enabling QC audio offload to avoid compile time
issues.

Changes in v3:
- Changed prefix from RFC to PATCH
- Rebased entire series to usb-next
- Updated copyright years

XHCI:
- Rebased changes on top of XHCI changes merged into usb-next, and only added
changes that were still under discussion.
- Added change to read in the "num-hc-interrupters" device property.

ASoC:
- qusb6 USB backend
  - Incorporated suggestions to fetch iommu information with existing APIs
  - Added two new sound kcontrols to fetch offload status and offload device
    selection.
    - offload status - will return the card and pcm device in use
        tinymix -D 0 get 1 --> 1, 0 (offload in progress on card#1 pcm#0)

    - device selection - set the card and pcm device to enable offload on. Ex.:
        tinymix -D 0 set 1 2 0  --> sets offload on card#2 pcm#0
                                    (this should be the USB card)

USB SND:
- Fixed up some locking related concerns for registering platform ops.
   - Moved callbacks under the register_mutex, so that 
- Modified APIs to properly pass more information about the USB SND device, so
that the Q6USB backend can build a device list/map, in order to monitor offload
status and device selection.

Changes in v2:

XHCI:
- Replaced XHCI and HCD changes with Mathias' XHCI interrupter changes
in his tree:
https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters

Adjustments made to Mathias' changes:
  - Created xhci-intr.h to export/expose interrupter APIs versus exposing xhci.h.
    Moved dependent structures to this file as well. (so clients can parse out
    information from "struct xhci_interrupter")
  - Added some basic locking when requesting interrupters.
  - Fixed up some sanity checks.
  - Removed clearing of the ERSTBA during freeing of the interrupter. (pending
    issue where SMMU fault occurs if DMA addr returned is 64b - TODO)

- Clean up pending events in the XHCI secondary interrupter.  While testing USB
bus suspend, it was seen that on bus resume, the xHCI HC would run into a command
timeout.
- Added offloading APIs to xHCI to fetch transfer and event ring information.

ASoC:
- Modified soc-usb to allow for multiple USB port additions.  For this to work,
the USB offload driver has to have a reference to the USB backend by adding
a "usb-soc-be" DT entry to the device saved into XHCI sysdev.
- Created separate dt-bindings for defining USB_RX port.
- Increased APR timeout to accommodate the situation where the AFE port start
command could be delayed due to having to issue a USB bus resume while
handling the QMI stream start command.

USB SND:
- Added a platform ops during usb_audio_suspend().  This allows for the USB
offload driver to halt the audio stream when system enters PM suspend.  This
ensures the audio DSP is not issuing transfers on the USB bus.
- Do not override platform ops if they are already populated.
- Introduce a shared status variable between the USB offload and USB SND layers,
to ensure that only one path is active at a time.  If the USB bus is occupied,
then userspace is notified that the path is busy.

Mathias Nyman (11):
  xhci: Add interrupt pending autoclear flag to each interrupter
  xhci: Add helper to set an interrupters interrupt moderation interval
  xhci: make isoc_bei_interval variable interrupter specific.
  xhci: remove unnecessary event_ring_deq parameter from
    xhci_handle_event()
  xhci: update event ring dequeue pointer position to controller
    correctly
  xhci: move event processing for one interrupter to a separate function
  xhci: add helper that checks for unhandled events on a event ring
  xhci: Don't check if the event ring is valid before every event TRB
  xhci: Decouple handling an event from checking for unhandled events
  xhci: add helper to stop endpoint and wait for completion
  xhci: sideband: add initial api to register a sideband entity

Wesley Cheng (39):
  usb: host: xhci: Export enable and disable interrupter APIs
  usb: host: xhci: Repurpose event handler for skipping interrupter
    events
  xhci: export XHCI IMOD setting helper for interrupters
  usb: host: xhci-sideband: Expose a sideband interrupter enable API
  usb: host: xhci-mem: Cleanup pending secondary event ring events
  usb: host: xhci-mem: Allow for interrupter clients to choose specific
    index
  ASoC: Add SOC USB APIs for adding an USB backend
  ASoC: dt-bindings: qcom,q6dsp-lpass-ports: Add USB_RX port
  ASoC: qcom: qdsp6: Introduce USB AFE port to q6dsp
  ASoC: qdsp6: q6afe: Increase APR timeout
  ASoC: qcom: qdsp6: Add USB backend ASoC driver for Q6
  ALSA: usb-audio: Introduce USB SND platform op callbacks
  ALSA: usb-audio: Export USB SND APIs for modules
  ALSA: usb-audio: Save UAC sample size information
  usb: dwc3: Specify maximum number of XHCI interrupters
  usb: host: xhci-plat: Set XHCI max interrupters if property is present
  ALSA: usb-audio: qcom: Add USB QMI definitions
  ALSA: usb-audio: qcom: Introduce QC USB SND offloading support
  ALSA: usb-audio: Check for support for requested audio format
  ASoC: usb: Add PCM format check API for USB backend
  ASoC: qcom: qdsp6: Ensure PCM format is supported by USB audio device
  ALSA: usb-audio: Prevent starting of audio stream if in use
  ALSA: usb-audio: Do not allow USB offload path if PCM device is in use
  ASoC: dt-bindings: Add Q6USB backend
  ASoC: dt-bindings: Update example for enabling USB offload on SM8250
  ALSA: usb-audio: qcom: Populate PCM and USB chip information
  ASoC: qcom: qdsp6: Add support to track available USB PCM devices
  ASoC: Introduce SND kcontrols to select sound card and PCM device
  ASoC: qcom: qdsp6: Add SOC USB offload select get/put callbacks
  ASoC: Add SND kcontrol for fetching USB offload status
  ASoC: qcom: qdsp6: Add PCM ops to track current state
  ASoC: usb: Create SOC USB SND jack kcontrol
  ASoC: qcom: qdsp6: Add headphone jack for offload connection status
  ASoC: usb: Fetch ASoC sound card information
  ALSA: usb-audio: Add USB offloading capable kcontrol
  ALSA: usb-audio: qcom: Use card and PCM index from QMI request
  ASoC: usb: Rediscover USB SND devices on USB port add
  ASoC: qcom: Populate SoC components string
  ASoC: doc: Add documentation for SOC USB

 .../devicetree/bindings/sound/qcom,q6usb.yaml |   55 +
 .../bindings/sound/qcom,sm8250.yaml           |   15 +
 Documentation/sound/soc/index.rst             |    1 +
 Documentation/sound/soc/usb.rst               |  611 ++++++
 drivers/usb/dwc3/core.c                       |   12 +
 drivers/usb/dwc3/core.h                       |    2 +
 drivers/usb/dwc3/host.c                       |    5 +-
 drivers/usb/host/Kconfig                      |    9 +
 drivers/usb/host/Makefile                     |    2 +
 drivers/usb/host/xhci-mem.c                   |   39 +-
 drivers/usb/host/xhci-plat.c                  |    2 +
 drivers/usb/host/xhci-ring.c                  |  240 ++-
 drivers/usb/host/xhci-sideband.c              |  439 ++++
 drivers/usb/host/xhci.c                       |   97 +-
 drivers/usb/host/xhci.h                       |   21 +-
 .../sound/qcom,q6dsp-lpass-ports.h            |    1 +
 include/linux/usb/xhci-sideband.h             |   70 +
 include/sound/q6usboffload.h                  |   20 +
 include/sound/soc-usb.h                       |  171 ++
 sound/soc/Kconfig                             |    9 +
 sound/soc/Makefile                            |    4 +
 sound/soc/qcom/Kconfig                        |    4 +
 sound/soc/qcom/common.c                       |   41 +
 sound/soc/qcom/common.h                       |    4 +-
 sound/soc/qcom/qdsp6/Makefile                 |    1 +
 sound/soc/qcom/qdsp6/q6afe-dai.c              |   60 +
 sound/soc/qcom/qdsp6/q6afe.c                  |  193 +-
 sound/soc/qcom/qdsp6/q6afe.h                  |   36 +-
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.c      |   23 +
 sound/soc/qcom/qdsp6/q6dsp-lpass-ports.h      |    1 +
 sound/soc/qcom/qdsp6/q6routing.c              |    9 +
 sound/soc/qcom/qdsp6/q6usb.c                  |  401 ++++
 sound/soc/qcom/sm8250.c                       |   14 +-
 sound/soc/soc-usb.c                           |  537 +++++
 sound/usb/Kconfig                             |   19 +
 sound/usb/Makefile                            |    3 +-
 sound/usb/card.c                              |  109 +
 sound/usb/card.h                              |   15 +
 sound/usb/endpoint.c                          |    1 +
 sound/usb/format.c                            |    1 +
 sound/usb/helper.c                            |    1 +
 sound/usb/mixer_usb_offload.c                 |   65 +
 sound/usb/mixer_usb_offload.h                 |   11 +
 sound/usb/pcm.c                               |  104 +-
 sound/usb/pcm.h                               |   11 +
 sound/usb/qcom/Makefile                       |    2 +
 sound/usb/qcom/qc_audio_offload.c             | 1913 +++++++++++++++++
 sound/usb/qcom/usb_audio_qmi_v01.c            |  892 ++++++++
 sound/usb/qcom/usb_audio_qmi_v01.h            |  162 ++
 49 files changed, 6289 insertions(+), 169 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6usb.yaml
 create mode 100644 Documentation/sound/soc/usb.rst
 create mode 100644 drivers/usb/host/xhci-sideband.c
 create mode 100644 include/linux/usb/xhci-sideband.h
 create mode 100644 include/sound/q6usboffload.h
 create mode 100644 include/sound/soc-usb.h
 create mode 100644 sound/soc/qcom/qdsp6/q6usb.c
 create mode 100644 sound/soc/soc-usb.c
 create mode 100644 sound/usb/mixer_usb_offload.c
 create mode 100644 sound/usb/mixer_usb_offload.h
 create mode 100644 sound/usb/qcom/Makefile
 create mode 100644 sound/usb/qcom/qc_audio_offload.c
 create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.c
 create mode 100644 sound/usb/qcom/usb_audio_qmi_v01.h


