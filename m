Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9A47BFFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjJJPJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjJJPJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:09:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1096BFB;
        Tue, 10 Oct 2023 08:09:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36685C433C7;
        Tue, 10 Oct 2023 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696950562;
        bh=1uN/KLzs4PFdrgQTDRe2eEIkgMT5dQZdcIQwi5D+gc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oixMLmUWvcoZqKAd0YyTCPl+qX0MbfO0IIYO59lqHm3TgBr/xwc6UrurG2TsU0jR9
         Lx57wflgKgOs3tDTdmO3iVwMwG4mX/AymBWRtuiaTbBIue7VA6Yq/R3c1YOSHFdHxQ
         e6oYGK9XlgiFUt2WQlFPbWhf+vkH2fcnduTfFLciqsfFODI07lVo1v5IYIVSDuEs4z
         aplswO1O9mhBCPV1ZsS4zg2EzwQUbqO9Toi2W06I/zePioJQgdOTA7Pk8TywXuIVUb
         ghzcfyw6aXqi1ofFVFkJbWNS9zGYdy7xtEbxhiTCjfn6aQfEb//pCGt/ESNECfz+Dj
         hHHz40TtD5ULQ==
Received: (nullmailer pid 884024 invoked by uid 1000);
        Tue, 10 Oct 2023 15:09:20 -0000
Date:   Tue, 10 Oct 2023 10:09:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, jonathan@marek.ca, andersson@kernel.org,
        quic_tdas@quicinc.com, linux-clk@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vladimir.zapolskiy@linaro.org,
        linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org,
        mturquette@baylibre.com
Subject: Re: [PATCH v2 2/3] media: dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Message-ID: <20231010150920.GA870095-robh@kernel.org>
References: <20231010122539.1768825-1-bryan.odonoghue@linaro.org>
 <20231010122539.1768825-3-bryan.odonoghue@linaro.org>
 <169694433325.625737.10533845261157845416.robh@kernel.org>
 <04374506-023d-4680-9f0f-77d6893288c4@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04374506-023d-4680-9f0f-77d6893288c4@nexus-software.ie>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 02:56:56PM +0100, Bryan O'Donoghue wrote:
> On 10/10/2023 14:25, Rob Herring wrote:
> > 
> > On Tue, 10 Oct 2023 13:25:38 +0100, Bryan O'Donoghue wrote:
> > > Add bindings for qcom,sc8280xp-camss in order to support the camera
> > > subsystem for sc8280xp as found in the Lenovo x13s Laptop.
> > > 
> > > Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > > ---
> > >   .../bindings/media/qcom,sc8280xp-camss.yaml   | 582 ++++++++++++++++++
> > >   1 file changed, 582 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.yaml
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/media/qcom,sc8280xp-camss.example.dts:26:18: fatal error: dt-bindings/clock/qcom,sc8280xp-camcc.h: No such file or directory
> >     26 |         #include <dt-bindings/clock/qcom,sc8280xp-camcc.h>
> >        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> I guess I should be embedding this
> 
> 
> This patch depends-on:
> https://lore.kernel.org/lkml/20231004161853.86382-2-bryan.odonoghue@linaro.org/T/
> 
> or
> 
> 
> This patch depends-on:
> https://lore.kernel.org/lkml/20231004161853.86382-2-bryan.odonoghue@linaro.org/T/#mc33be3fef01bffe892f72bd5e567dba6a047283b
> 
> below the "---" in this patch directly, instead of in the series description
> ?

I preferred in the patch itself, but now it doesn't really matter as far 
as getting a report goes. They go out now without my review. So you get 
them faster, but I can't handle dependencies unless there's a standard 
way a script can. There's 'base-commit' but I don't think that's used 
enough to rely on and it doesn't work if the dependency is not yet 
applied and in linux-next.

I'd still put the dependency here, so it's quoted in the report.

Rob
