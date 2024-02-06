Return-Path: <linux-kernel+bounces-54454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E95484AF76
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0BA1F233F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7056E39AD5;
	Tue,  6 Feb 2024 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qlgTGDLM"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F912A157
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206456; cv=none; b=eOgNwVBnluYJtYvo6EAzDN1PhU8Az0lycNOqSbPGzch3gBi1EduKUbIHLcKKql7DE8RL7yedn5dALmMr3bU4hJQhfXnkE4TKsDYYg1MAMl+wuvh9Yghx59JAs9ODFHIeXHL/a5FU9FQXfWQqlA8aGvovZSWLSmr/h2twSpWillQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206456; c=relaxed/simple;
	bh=AWx2NUiExhoQKsNrxm0p9/RvTSOrwrTthLindA4bsP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rhfe3y3s1O/oLY/bvP3niUhRFg2EJHXBLLWEOcNkkJ1fyglYAroU4aV1ijkY+aMC9p0HVlevYHV8//SPsvhWMstnazGBncSBCdNPEXN5OuIcu7eGULYgZpDcDTcg1kItQO/MPwUlgGkqq3LT53cW86uvQBMDTfHOKzK2JpZ0hBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qlgTGDLM; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6de8a699dso4452887276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 00:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707206452; x=1707811252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+qm+TNS+HjiQfvofyoDx/1vFeT5+PQGenxfb19wo7Is=;
        b=qlgTGDLMpG5pREB6eZzMLJ7CRlULzG6IY1VBH4BtbwTnLYOULpzXuwsWieZ/hr8EF5
         aP60XtH55+rC1Q72H6ttRfGqFbCeeGka34B2r0g8UrtWMDtjFfee9Eccvtk0AsafAVJ5
         4XzJgRtcRpBy+ztsTK9Uq9mFm6lxrLgCGzNB6cMi3v5Di50n/j30JueL1iO34tThzcwj
         uQn6D6OTO1GWf/iVz02Y4YNkz6zhMZARdHZCosbjM+4SVuFziOq6OCBkaCgeHqYGuCmj
         +y8QD7QhDwumiBZ2gjfyb5dlTamwGldOHbrdlheE8xytNBXxDZp3QGM1v7bZOjkOVS1D
         +kqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707206452; x=1707811252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qm+TNS+HjiQfvofyoDx/1vFeT5+PQGenxfb19wo7Is=;
        b=UfWHfkIE2U6USxJFbinPa3V1vM45XTo5tlZPNSiGbDudYLluH4AyXk5YyK8auoempP
         XWQEk52Y5FATbIVhVUaz0/uIPzwtuUCov8uw/WZdVVWOg9V9jC1YroEDAz47piuGpLYe
         bGSjNiZ3PQ/2Qm1B2ZqWyRx7rGkG5n2OBuoF5CkCJHFwGR73fRrF0FdmfWgXMgBzwVY5
         iYlecD3F8krQc0dtDwbri6WZmKR2U8YuiJvYAexM7G8V83Gx7H8Ks8p5dJjNXqWZ3Uw/
         VLGmKfkp70Z5O3iHGHSl2y//82SR3nuXgeykO5jD9q7u3tUojP+vygXV16kyl4hw5PzZ
         Gxbw==
X-Gm-Message-State: AOJu0YyjBQ1rvMwBcKBgAKXzZXf7j5YTUjHsgJhbRz0uncpXel1+R7SX
	yaSojIvRWAP+4M0awrllEJ4ugEwlIs+djthTe43Rp2qsFE6uysMCqr+psPsIFddmJR/Z1KtYq8e
	LoijdtgmZzl3K0XifBTjuAwWRuzrdJrcpKZk+CQ==
X-Google-Smtp-Source: AGHT+IEx4Vh46JN/QJfqYWQmqVGPAH88bfjAZG0I37mhSKSHTqH93FJJeoByIgPQOpGCuRXX+i7Z4Gdpn9n37COm1n8=
X-Received: by 2002:a25:ae45:0:b0:dc6:b190:9341 with SMTP id
 g5-20020a25ae45000000b00dc6b1909341mr817045ybe.49.1707206452106; Tue, 06 Feb
 2024 00:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
In-Reply-To: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 6 Feb 2024 10:00:41 +0200
Message-ID: <CAA8EJpopE91TSCkworWts82tcD_6PLgLmes_FhVhnUovmQWz_w@mail.gmail.com>
Subject: Re: [PATCH v14 0/9] Add multiport support for DWC3 controllers
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"

Hi Krishna,

On Tue, 6 Feb 2024 at 07:18, Krishna Kurapati <quic_kriskura@quicinc.com> wrote:
>
> Currently the DWC3 driver supports only single port controller which
> requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
> DWC3 controller with multiple ports that can operate in host mode.
> Some of the port supports both SS+HS and other port supports only HS
> mode.
>
> This change primarily refactors the Phy logic in core driver to allow
> multiport support with Generic Phy's.
>
> Changes have been tested on  QCOM SoC SA8295P which has 4 ports (2
> are HS+SS capable and 2 are HS only capable).

Thank you for your patches! Have you tested how this patchset
interacts with the USB role-switching?

I'm asking because it might be easier to define DT nodes for each of
USB ports, which can carry the PHY properties (and also other DT
properties if that's required, e.g. the ports / endpoints and
usb-role-switch) rather than pushing all USB PHY links to the root DT
node.

>
> Changes in v14:
> Moved wrapper binding update to 5th patch in the series as it deals
> with only wakeup and not enumeration. The first part of the series
> deals with enumeration and the next part deals with wakeup.
> Updated commit text for wrapper driver patches.
> Added error checks in get_port_index and setup_irq call which were
> missing in v13.
> Added SOB and CDB tags appropriately for the patches.
> Rebased code on top of latest usb next.
> DT changes have been removed and will be sent as a seperate series.
>
> Changes in v13:
> This series is a subset of patches in v11 as the first 3 patches in v11
> have been mereged into usb-next.
> Moved dr_mode property from platform specific files to common sc8280xp DT.
> Fixed function call wrapping, added comments and replaced #defines with
> enum in dwc3-qcom for identifying IRQ index appropriately.
> Fixed nitpicks pointed out in v11 for suspend-resume handling.
> Added reported-by tag for phy refactoring patch as a compile error was
> found by kernel test bot [1].
> Removed reviewed-by tag of maintainer for phy refactoring patch as a minor
> change of increasing phy-names array size by 2-bytes was done to fix
> compilation issue mentioned in [1].
>
> Changes in v12:
> Pushed as a subset of acked but no-yet-merged patches of v11 with intent
> of making rebase of other patches easy. Active reviewers from community
> suggested that it would be better to push the whole series in one go as it
> would give good clarity and context for all the patches in the series.
> So pushed v13 for the same addressing comments received in v11.
>
> Changes in v11:
> Implemented port_count calculation by reading interrupt-names from DT.
> Refactored IRQ handling in dwc3-qcom.
> Moving of macros to xhci-ext-caps.h made as a separate patch.
> Names of interrupts to be displayed on /proc/interrupts set to the ones
> present in DT.
>
> Changes in v10:
> Refactored phy init/exit/power-on/off functions in dwc3 core
> Refactored dwc3-qcom irq registration and handling
> Implemented wakeup for multiport irq's
> Moved few macros from xhci.h to xhci-ext-caps.h
> Fixed nits pointed out in v9
> Fixed Co-developed by and SOB tags in patches 5 and 11
>
> Changes in v9:
> Added IRQ support for DP/DM/SS MP Irq's of SC8280
> Refactored code to read port count by accessing xhci registers
>
> Changes in v8:
> Reorganised code in patch-5
> Fixed nitpicks in code according to comments received on v7
> Fixed indentation in DT patches
> Added drive strength for pinctrl nodes in SA8295 DT
>
> Changes in v7:
> Added power event irq's for Multiport controller.
> Udpated commit text for patch-9 (adding DT changes for enabling first
> port of multiport controller on sa8540-ride).
> Fixed check-patch warnings for driver code.
> Fixed DT binding errors for changes in snps,dwc3.yaml
> Reabsed code on top of usb-next
>
> Changes in v6:
> Updated comments in code after.
> Updated variables names appropriately as per review comments.
> Updated commit text in patch-2 and added additional info as per review
> comments.
> The patch header in v5 doesn't have "PATHCH v5" notation present. Corrected
> it in this version.
>
> Changes in v5:
> Added DT support for first port of Teritiary USB controller on SA8540-Ride
> Added support for reading port info from XHCI Extended Params registers.
>
> Changes in RFC v4:
> Added DT support for SA8295p.
>
> Changes in RFC v3:
> Incase any PHY init fails, then clear/exit the PHYs that
> are already initialized.
>
> Changes in RFC v2:
> Changed dwc3_count_phys to return the number of PHY Phandles in the node.
> This will be used now in dwc3_extract_num_phys to increment num_usb2_phy
> and num_usb3_phy.
> Added new parameter "ss_idx" in dwc3_core_get_phy_ny_node and changed its
> structure such that the first half is for HS-PHY and second half is for
> SS-PHY.
> In dwc3_core_get_phy, for multiport controller, only if SS-PHY phandle is
> present, pass proper SS_IDX else pass -1.
>
> Tested enumeration and wakeup on all ports:
>
> / # lsusb
> Bus 001 Device 001: ID 1d6b:0002
> Bus 001 Device 018: ID 0781:5567
> Bus 001 Device 020: ID 03f0:134a
> Bus 002 Device 002: ID 18d1:4ee1
> Bus 002 Device 001: ID 1d6b:0003
> / #
> / # dmesg | grep ports
> [    0.224450] hub 1-0:1.0: 4 ports detected
> [    0.230479] hub 2-0:1.0: 2 ports detecte/ #
> / #
> / # cat /proc/interrupts  |grep phy
> 158:          1          0          0          0          0          0          0          0       PDC 127 Edge      dp_hs_phy_1
> 159:          2          0          0          0          0          0          0          0       PDC 126 Edge      dm_hs_phy_1
> 160:          6          0          0          0          0          0          0          0       PDC 129 Edge      dp_hs_phy_2
> 161:          3          0          0          0          0          0          0          0       PDC 128 Edge      dm_hs_phy_2
> 162:          1          0          0          0          0          0          0          0       PDC 131 Edge      dp_hs_phy_3
> 163:          2          0          0          0          0          0          0          0       PDC 130 Edge      dm_hs_phy_3
> 164:          2          0          0          0          0          0          0          0       PDC 133 Edge      dp_hs_phy_4
> 165:          3          0          0          0          0          0          0          0       PDC 132 Edge      dm_hs_phy_4
> 166:          0          0          0          0          0          0          0          0       PDC  16 Level     ss_phy_1
> 167:          0          0          0          0          0          0          0          0       PDC  17 Level     ss_phy_2
>
> Links to previous versions:
> Link to v13: https://lore.kernel.org/all/20231007154806.605-1-quic_kriskura@quicinc.com/
> Link to v12: https://lore.kernel.org/all/20231004165922.25642-1-quic_kriskura@quicinc.com/
> Link to v11: https://lore.kernel.org/all/20230828133033.11988-1-quic_kriskura@quicinc.com/
> Link to v10: https://lore.kernel.org/all/20230727223307.8096-1-quic_kriskura@quicinc.com/
> Link to v9: https://lore.kernel.org/all/20230621043628.21485-1-quic_kriskura@quicinc.com/
> Link to v8: https://lore.kernel.org/all/20230514054917.21318-1-quic_kriskura@quicinc.com/
> Link to v7: https://lore.kernel.org/all/20230501143445.3851-1-quic_kriskura@quicinc.com/
> Link to v6: https://lore.kernel.org/all/20230405125759.4201-1-quic_kriskura@quicinc.com/
> Link to v5: https://lore.kernel.org/all/20230310163420.7582-1-quic_kriskura@quicinc.com/
> Link to RFC v4: https://lore.kernel.org/all/20230115114146.12628-1-quic_kriskura@quicinc.com/
> Link to RFC v3: https://lore.kernel.org/all/1654709787-23686-1-git-send-email-quic_harshq@quicinc.com/#r
> Link to RFC v2: https://lore.kernel.org/all/1653560029-6937-1-git-send-email-quic_harshq@quicinc.com/#r
>
> Harsh Agarwal (1):
>   usb: dwc3: core: Refactor PHY logic to support Multiport Controller
>
> Krishna Kurapati (8):
>   dt-bindings: usb: Add bindings for multiport properties on DWC3
>     controller
>   usb: dwc3: core: Access XHCI address space temporarily to read port
>     info
>   usb: dwc3: core: Skip setting event buffers for host only controllers
>   dt-bindings: usb: qcom,dwc3: Add bindings for SC8280 Multiport
>   usb: dwc3: qcom: Add helper function to request wakeup interrupts
>   usb: dwc3: qcom: Refactor IRQ handling in glue driver
>   usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
>   usb: dwc3: qcom: Add multiport suspend/resume support for wrapper
>
>  .../devicetree/bindings/usb/qcom,dwc3.yaml    |  33 ++
>  .../devicetree/bindings/usb/snps,dwc3.yaml    |  13 +-
>  drivers/usb/dwc3/core.c                       | 326 +++++++++++++----
>  drivers/usb/dwc3/core.h                       |  19 +-
>  drivers/usb/dwc3/drd.c                        |  15 +-
>  drivers/usb/dwc3/dwc3-qcom.c                  | 329 ++++++++++++------
>  6 files changed, 534 insertions(+), 201 deletions(-)
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

