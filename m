Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5027E2FEF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbjKFWha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjKFWh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:37:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1379BD51;
        Mon,  6 Nov 2023 14:37:25 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6LocKp012416;
        Mon, 6 Nov 2023 22:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=qcppdkim1;
 bh=Axhqdj44LXREwOcAc3+OGJljF+Zqtf7gkAFBPL7WTUQ=;
 b=PBNQTth6HskJM9OEKmq6DBb4K6cmfJtFjWFuUDHoQLcTvbVS8Jx2ZEycAu7tgI82jjaG
 6Z3qW4LFh957x7BEHlplYGUcLtM3Ci+XimsrgD1Zq9QxYEZWMXtJyFF2XRdTarq0FlyP
 WcJUU2xwhTnv+IAQx/HXPmNVHnA+EDIs2ymqkrRG4fSTsW3l+caAbCKy+ZGqgGrEYhnp
 YEDcPDum0ar2wRtbpx0zrBEY0jEo63ivGRhaSShiva0vKK+tKIM0OkDovSQXRQGewlwj
 44K8kYA8dl0ZdM3S/JxYI7zX2jPxwoUzNIFH60yy5MaAE3sQpDIHFHZWsb14KADEeO8x YQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u72bth11c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 22:36:54 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6MarqS024021
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 22:36:53 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 14:36:52 -0800
Date:   Mon, 6 Nov 2023 14:36:51 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Doug Anderson <dianders@chromium.org>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-watchdog@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andy Gross <agross@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Kees Cook <keescook@chromium.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Tony Luck <tony.luck@intel.com>,
        <cros-qcom-dts-watchers@chromium.org>,
        <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] arm64: dts: qcom: sc7180: Make watchdog bark
 interrupt edge triggered
Message-ID: <20231106223651.GZ3553829@hu-bjorande-lv.qualcomm.com>
References: <20231103163434.1.Ic7577567baff921347d423b722de8b857602efb1@changeid>
 <CAE-0n50vtad5hkkAuV-hvsnm+tTevd_4OSr3iGofBa5L8A0RQw@mail.gmail.com>
 <CAD=FV=UJE6VKrjFJ2g=4qRHLdnqymossWSAFeKyUykxm1sTCtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UJE6VKrjFJ2g=4qRHLdnqymossWSAFeKyUykxm1sTCtQ@mail.gmail.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O6ZoRgqUeWM1cDED-Pa0nTdiJj8O354e
X-Proofpoint-GUID: O6ZoRgqUeWM1cDED-Pa0nTdiJj8O354e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 01:52:58PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Mon, Nov 6, 2023 at 1:49 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Douglas Anderson (2023-11-03 16:34:27)
> > > On sc7180 when the watchdog timer fires your logs get filled with:
> > >   watchdog0: pretimeout event
> > >   watchdog0: pretimeout event
> > >   watchdog0: pretimeout event
> > >   ...
> > >   watchdog0: pretimeout event
> > >
> > > If you're using console-ramoops to debug crashes the above gets quite
> > > annoying since it blows away any other log messages that might have
> > > been there.
> > >
> > > The issue is that the "bark" interrupt (AKA the "pretimeout"
> > > interrupt) remains high until the watchdog is pet. Since we've got
> > > things configured as "level" triggered we'll keep getting interrupted
> > > over and over.
> > >
> > > Let's switch to edge triggered. Now we'll get one interrupt when the
> > > "bark" interrupt goes off we'll get one interrupt and won't get
> >
> > "We'll get one" twice?
> 
> I like to make like to make typos. If you hadn't hadn't noticed.
> 
> I'll wait another few days and send a version with the typo fixed
> unless Bjorn tells me not to (because he didn't care and applied it
> anyway or because he fixed it himself while applying).
> 

I'd be happy to pick your resubmitted series. Thanks for cleaning this
up across the platforms.

Regards,
Bjorn

> 
> > > another one until the "bark" interrupt is cleared and asserts again.
> > >
> > > This matches how many older Qualcomm SoCs have things configured.
> > >
> > > Fixes: 28cc13e4060c ("arm64: dts: qcom: sc7180: Add watchdog bark interrupt")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> >
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> 
> Thanks!
> 
> -Doug
