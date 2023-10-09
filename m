Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C767BEB92
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378615AbjJIUXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378520AbjJIUXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:23:45 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CA29E;
        Mon,  9 Oct 2023 13:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696883022; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rMbT6c826GkSWoyGW21+7pebzEAf3PIproWGGx/TfE2I6+qt8IV9piryhuehChz62u
    kozbIlgSL8UMmcSAPS3fPCN6TC/OGEuyTS84u0omMOF2PuACtf6ubb3/gMvT8F2myffa
    jZyakQvv+2w0qNPliB4xQv3d7uHLAp+CbC5naSuDnsa0o6wLWG/lqyrW7cTNoPsOtZpO
    C2meYAkEYNjhbBIYY1vyMKCXgkhCcu8EKRQTjh90uQFHuhOLFuLdM/qGKvobgvIQJsHR
    ekeYLR264nABH2E3Un48QvzwWKA066WQ/KUs4UYIqsZ6oKFuOWdnUzOHvks6ZX1craVJ
    2E2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696883022;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0LE16Y3s0lp+JxctX/Ykew2sWggFRhtwCau0rpkKVRY=;
    b=QZRT8lBGinSMJ86e2EvD3BXX6ptNaRujh8+TbhCXVFTOygIY5qYeoxrnOJpY+ySjXt
    s1wx7EUB25nWOE5x5pDdET85dUJ3xV7e7iEk96RnEj9WFkKBkdRn/9htD0/qtxZgjwhR
    LIrYWlF8mboaztBvp2oHhfRdleA3zVzyfseeWRCVBjZIlOCCmmopulL2AGDq7rIQ5XGO
    C6hBKTgXi2sV6N8mQVkMsdczL9hGRnwLcqYD9GepgbAtGNlU0PFMuUP9/AX/c5nw8djo
    3sNSUWc43CRuEVVbQhFJ3webNwZP5o2ovHoZ9YQGUZpbszHClJUfdqCslb8WmqJVd5+p
    aASA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696883022;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0LE16Y3s0lp+JxctX/Ykew2sWggFRhtwCau0rpkKVRY=;
    b=Ad7mH5eJORTzZzLFOeGCJJbECL/fIObNpDEb0wiZSvEuVQCWbCQxhTgIsvv+7NXVqE
    qq3jvGX6EgzxST9tdrcizyqJSInPL1+jcTlUVnCSCQkSQ6UdoVQNbY0xc5wWLliqwTiJ
    QTiHq6NldlKVVj92OH/Ni/6GiRsJmbBdYn+AphqXEwgBRCZUOPAdPNyWQ2bI4nv0QqB7
    LecFqCI7p+WYNHoAcyDQ9cigIs2ff6pw6YrUsu/mNW8lVvupVjKuGQQTBXWsDh5z6eWo
    EphXWn/PUEz0TxkjNtjJ49EFQgDZTDws3DEe8BDRUN8pf+t7AOtCqV7njG1aBnveXtXo
    3qCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696883022;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0LE16Y3s0lp+JxctX/Ykew2sWggFRhtwCau0rpkKVRY=;
    b=5qq9AEjdZJhI9q1aeOF7+OEt7bxVMWgbk6Zz/EvZL1uQjKj4tXQaqZo45Cu116WRei
    Ck/+aDqeFMnJneHUfABg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA+p3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z99KNgQC5
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 9 Oct 2023 22:23:42 +0200 (CEST)
Date:   Mon, 9 Oct 2023 22:23:40 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] regulator: qcom_smd: Disable unused regulators
Message-ID: <ZSRhTIqYX7hQ0_lc@gerhold.net>
References: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
 <20231004-reg-smd-unused-v1-2-5d682493d555@kernkonzept.com>
 <9b7744bf-d42c-4922-85e8-ca4777f313a7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b7744bf-d42c-4922-85e8-ca4777f313a7@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 11:15:40PM +0200, Konrad Dybcio wrote:
> On 4.10.2023 16:17, Stephan Gerhold wrote:
> > The RPM firmware on Qualcomm platforms does not provide a way to check
> > if a regulator is on during boot using the SMD interface. If the
> > regulators are already on during boot and Linux does not make use of
> > them they will currently stay enabled forever. The regulator core does
> > not know these regulators are on and cannot clean them up together with
> > the other unused regulators.
> > 
> > Fix this by setting the initial enable state to -EINVAL similar to
> > qcom-rpmh-regulator.c. The regulator core will then also explicitly
> > disable all unused regulators with unknown status.
> > 
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> > ---
> > NOTE: This has a slight potential of breaking boards that rely on having
> > unused regulators permanently enabled (without regulator-always-on).
> > However, this is always a mistake in the device tree so it's probably
> > better to risk some breakage now, add the missing regulators and avoid
> > this problem for all future boards.
> > ---
> >  drivers/regulator/qcom_smd-regulator.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> > index f53ada076252..0bbfba2e17ff 100644
> > --- a/drivers/regulator/qcom_smd-regulator.c
> > +++ b/drivers/regulator/qcom_smd-regulator.c
> > @@ -53,14 +53,14 @@ static int rpm_reg_write_active(struct qcom_rpm_reg *vreg)
> >  		reqlen++;
> >  	}
> >  
> > -	if (vreg->uv_updated && vreg->is_enabled) {
> > +	if (vreg->uv_updated && vreg->is_enabled > 0) {
> At a quick glance, are there any states for this value, other
> than 0 and 1? This is not the regulator_ops->is_enabled, but
> qcom_rpm_reg->is_enabled.
> 

Yes, I initially assign vreg->is_enabled = -EINVAL (for use with PATCH
1/2). It's in the part of the patch that you trimmed in your reply. :D

Thanks,
Stephan

@@ -1377,6 +1377,7 @@ static int rpm_regulator_init_vreg(struct qcom_rpm_reg *vreg, struct device *dev
 	vreg->rpm	= rpm;
 	vreg->type	= rpm_data->type;
 	vreg->id	= rpm_data->id;
+	vreg->is_enabled = -EINVAL;
 
 	memcpy(&vreg->desc, rpm_data->desc, sizeof(vreg->desc));
 	vreg->desc.name = rpm_data->name;
