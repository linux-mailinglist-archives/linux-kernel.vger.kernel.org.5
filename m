Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C28C7EF5BC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjKQPyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQPyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:54:08 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B988E;
        Fri, 17 Nov 2023 07:54:05 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AHFqPD0014089;
        Fri, 17 Nov 2023 09:53:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=qcmoqM99WUT5mR4
        4BmGtdcfqukhABXd6uBe07IyrQRE=; b=AGM0SlwusSlH9E1NPc0M7AEAgKk3qYB
        qahD0GReg2zT48lm2KuZsCyD7G7xQzKSA1cSAg8/XFRmYqeuA7azrET+cMLkZVIS
        mzYiIprojjDLKU9DSaqL81qPrtNA+m/klhJhSGRYxqXk/CCfIQf9+bEWgU6R4y9g
        CxsW448ENb8IPH+clKPIq50qrnakhVtYTaMsJrsOBVbMfoccWNfMOlE1kSf7LMpt
        rmlKaAQKPmTIhLhkZ7wm3D75Vf212FXN7eqq7abfc6+ev1OC5gZszlda47EPxmny
        lCpQKnp+/PW2lvQkT7OJLFZNFECi3psy/h2rd5qxOGSKkaBs0Mp3rvA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ua7w2qp27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 09:53:55 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 15:53:53 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Fri, 17 Nov 2023 15:53:53 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9F8B1B12;
        Fri, 17 Nov 2023 15:53:53 +0000 (UTC)
Date:   Fri, 17 Nov 2023 15:53:53 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] ASoC: cs43130: Fixes and improvements
Message-ID: <20231117155353.GG32655@ediswmail.ad.cirrus.com>
References: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: 0x5K93HMr0eactcOtCnesHZrrH9SZOeO
X-Proofpoint-GUID: 0x5K93HMr0eactcOtCnesHZrrH9SZOeO
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 02:13:37PM +0000, Maciej Strozek wrote:
> This patchset aims to add minor fixes (first two patches) and
> introduce general improvements to the driver (rest of the patches)
> 
> Maciej Strozek (7):
>   ASoC: cs43130: Fix the position of const qualifier
>   ASoC: cs43130: Fix incorrect frame delay configuration
>   ASoC: cs43130: Allow configuration of bit clock and frame inversion
>   ASoC: cs43130: Store device in private struct and use it more
>     consistently
>   ASoC: cs43130: Add handling of ACPI
>   ASoC: cs43130: Allow driver to work without IRQ thread
>   ASoC:cs43130: Add switch to control normal and alt hp inputs
> 
>  sound/soc/codecs/cs43130.c | 311 ++++++++++++++++++++++++-------------
>  sound/soc/codecs/cs43130.h |   3 +
>  2 files changed, 204 insertions(+), 110 deletions(-)
> 
> --

Series looks good to me:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
