Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A507801A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356067AbjHQXXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356128AbjHQXXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:23:46 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74843592;
        Thu, 17 Aug 2023 16:23:43 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C832F741;
        Fri, 18 Aug 2023 01:22:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692314548;
        bh=2ci2ODvSHHVFwJqInqV3ww3u6hO/6wvKge8jSVGOA+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T/QM6YH/N4ane/W98rZZRn7Te+dVAzjl141913f3K6sbda0WVnsML218mz4xlUXAW
         fpWruzdWnXAlHyTN8C9X++NHZylnUkY7Qbz38SwOCSsqksXKJI4A8OuKboH6WNZ8gl
         6ybGQMYZ1c4ivPvmJR2w053hblBGDXklG9uWKTjE=
Date:   Fri, 18 Aug 2023 02:23:48 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag
 to give credits to who sponsored the patch
Message-ID: <20230817232348.GC1175@pendragon.ideasonboard.com>
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
 <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giulio,

On Fri, Aug 18, 2023 at 12:09:57AM +0200, Giulio Benetti wrote:
> Sometimes it happens that a Company or a Physical Person sponsors the
> creation and/or the upstreaming process of a patch, but at the moment
> there is no way to give credits to it. There are some commit that include
> a sort of tag "Sponsored by" without the dash to avoid
> scripts/checkpatch.pl to complain but a real standard has not been defined.
> With this patch let's try to define a method to give credits consistently
> including an acknowledge from the sponsor. The goal is to improve
> contributions from companies or physical persons that this way should gain
> visibility in Linux kernel and so they should be more prone to let the
> work done for them for to be upstreamed.

Just adding one data point here, without judging on the merits of this
proposal. I've been requested previously by customers to increase their
visibility in the kernel development statistics, and the way we found to
do so was to sign-off patches with

Laurent Pinchart <laurent.pinchart+customer@ideasonboard.com>

(where "customer" is to be replaced with the customer name).

> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>  Documentation/process/submitting-patches.rst | 38 ++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index efac910e2659..870e6b5def3f 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -600,6 +600,44 @@ process nor the requirement to Cc: stable@vger.kernel.org on all stable
>  patch candidates. For more information, please read
>  Documentation/process/stable-kernel-rules.rst.
>  
> +Using Sponsored-by:
> +-------------------
> +
> +A Sponsored-by tag gives credit to who sponsored the creation and/or the
> +upstreaming process of the patch. Sponsored-by can contain a company name or
> +a physical person name. If a company sponsored the patch this is the form::
> +
> +	Company Name <mail@companyname.com>
> +
> +where the Company Name must be a valid Business Name at the time of sending the
> +patch until the confirmation of the Sponsored-by tag, while the e-mail can be
> +either a generic e-mail the company can be reached out or an e-mail of a person
> +who has the rights inside it to confirm the Sponsored-by tag.
> +
> +If a physical person sponsored the patch the form must be same used in
> +Signed-off-by tag::
> +
> +	Physical Person <physical.person@mail.com>
> +
> +In both cases, to prevent fake credits, either the company or the person should
> +send an Acked-by tag placed right under Sponsored-by tag using the same form
> +described above. So for example if the patch contains::
> +
> +	<changelog>
> +
> +	Sponsored-by: Company Name <mail@companyname.com>
> +	Signed-off-by: Developer Name <developer.name@developername.com>
> +
> +The result including the answer from the sponsor must be::
> +
> +	<changelog>
> +
> +	Sponsored-by: Company Name <mail@companyname.com>
> +	Acked-by: Company Name <mail@companyname.com>
> +	Signed-off-by: Developer Name <developer.name@developername.com>
> +
> +This way the sponsor agrees to the usage of this tag using its name.
> +
>  .. _the_canonical_patch_format:
>  
>  The canonical patch format

-- 
Regards,

Laurent Pinchart
