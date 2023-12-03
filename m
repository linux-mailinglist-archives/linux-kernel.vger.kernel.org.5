Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D81F8020C3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjLCEhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCEho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:37:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626B9106
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:37:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DA1C433C9;
        Sun,  3 Dec 2023 04:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701578267;
        bh=efSYakHRaNQ1HmzcXaErAE3GqG/WjaPldXZV31BdrcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D7aICsSMqliUYyoJB0YbhECQt/0vJdaUvo4Gw9DoqvJfMURFazIoPSSH7pylHfmgM
         igKRHYrW8qbRMylp5GSXv6s1KT6BcqyAMEASBqU8Dph5uRuMBvX7kTlQxqNAIa3atB
         vUAnUzCjdXgiadkOIcehCupDZ0J/rz8Ws+NvyGr05Cxjo62GTHSDArE0cDnN+6UB6P
         KxOkpJtyrQziSvUGabIV2APcP4ICMIWOC5+0uw846pZRJVk5USx0KMDniFN08ZxW0I
         KzjrKAUgJLm6Q5MCVeM9BK3ds+4hWQkmMeePw/E9QH7mpnnnO9UNZXUv3Ntf39uIxS
         gvM7W7dNYaXhA==
Date:   Sat, 2 Dec 2023 20:41:12 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable UFS
Message-ID: <dutd7zn5avelyujiyb6k64luzu2pqccy6ywhfj52i4g2m6ld47@2aqstxoekqrq>
References: <20231002-fp5-ufs-v2-1-e2d7de522134@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002-fp5-ufs-v2-1-e2d7de522134@fairphone.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 02:30:41PM +0200, Luca Weiss wrote:
> Enable the UFS phy and controller so that we can access the internal
> storage of the phone.
> 
> At the same time we need to bump the minimum voltage used for UFS VCC,
> otherwise it doesn't initialize properly. The 2.952V is taken from the
> vcc-voltage-level property downstream.
> 
> See also the following link for more information about the VCCQ/VCCQ2:
> https://gerrit-public.fairphone.software/plugins/gitiles/kernel/msm-extra/devicetree/+/1590a3739e7dc29d2597307881553236d492f188/fp5/yupik-idp-pm7250b.dtsi#207
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Depends on: https://lore.kernel.org/linux-arm-msm/20230927081858.15961-1-quic_nitirawa@quicinc.com/

I'd love to merge this patch, but this dependency doesn't seem to make
progress, please consider fixing up the outstanding feedback and posting
v5.

Regards,
Bjorn
