Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9B57B58D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbjJBRDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbjJBRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:03:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9221EAB;
        Mon,  2 Oct 2023 10:03:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB023C433C7;
        Mon,  2 Oct 2023 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696266207;
        bh=eTPkDa6a/QY4l/amWClioZkJAZkSQGjRiz057XQ/UYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aCy6+hI5eNsm3aL4CMUwUls8d64SXntTTk626CotTyBSXXABXchdii7bUkfTJQ3Pl
         6NZwzqmBiblpP2gp0NO3RwVrcj+UhCsBkrb//iSMR/4D7SYQVPkGV3m59e7O56s60h
         GuS1teww0a6KQN1jIouDyPArYnt+i+u82LI3fWYEPN4Q/BB6HE5xZCu3gcAhFX3wut
         MMZ1HHDwp0wd3/aqZ6fBfgX9yfFtc+SGYBWi/pqjNqCsqB8JYvWqVAUdygD/n6eViX
         oRzDlVnSnqWc6/JY46787qdZSvuqo47KMILclhGZ56Egiq1DhAy/HV3KRDDrOZDZTw
         87gK0CQ7F1wqw==
Received: (nullmailer pid 1941416 invoked by uid 1000);
        Mon, 02 Oct 2023 17:03:24 -0000
Date:   Mon, 2 Oct 2023 12:03:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: qcom,spmi-pmic: Update gpio example
Message-ID: <20231002170324.GA1934850-robh@kernel.org>
References: <20230929-pm7250b-gpio-fixup-v1-0-ef68543c1d3b@fairphone.com>
 <20230929-pm7250b-gpio-fixup-v1-1-ef68543c1d3b@fairphone.com>
 <510d6407-8033-4f2e-aabf-bd3fb84875a9@linaro.org>
 <CVXQXI5E053J.386OVO28LNSYT@otso>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CVXQXI5E053J.386OVO28LNSYT@otso>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 08:40:10AM +0200, Luca Weiss wrote:
> On Sat Sep 30, 2023 at 5:06 PM CEST, Krzysztof Kozlowski wrote:
> > On 29/09/2023 10:17, Luca Weiss wrote:
> > > As per commit ea25d61b448a ("arm64: dts: qcom: Use plural _gpios node
> > > label for PMIC gpios") all dts files now use the plural _gpios instead
> > > of the singular _gpio as label. Update the schema example also to match.
> > > 
> > > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > > index 55e931ba5b47..e4842e1fbd65 100644
> > > --- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> > > @@ -245,7 +245,7 @@ examples:
> > >              #address-cells = <1>;
> > >              #size-cells = <0>;
> > >  
> > > -            pmi8998_gpio: gpio@c000 {
> > > +            pmi8998_gpios: gpio@c000 
> >
> > This does no make sense... you update label only here, but not in any
> > user of it which proves that label is not used. If it is not used, it
> > should be dropped, not changed...
> 
> Okay, I will drop the label instead of updating it in v2.

Or just drop the patch and skip the trivial changes. If you want to fix 
unused labels, fix it for the whole subsystem (mfd) or treewide.

Rob
