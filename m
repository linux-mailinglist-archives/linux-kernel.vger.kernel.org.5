Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AC67687CE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjG3UJg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 30 Jul 2023 16:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjG3UJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:09:34 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD5811C
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 13:09:33 -0700 (PDT)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id A6F0514092B;
        Sun, 30 Jul 2023 20:09:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id E055420010;
        Sun, 30 Jul 2023 20:09:27 +0000 (UTC)
Message-ID: <15913bee637e2cff63626dc64c0577abc1ad9c6c.camel@perches.com>
Subject: Re: [PATCH v7 2/2] cxl/region: Remove else after return statement
From:   Joe Perches <joe@perches.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Raghu Halharvi <raghuhack78@gmail.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>
Date:   Sun, 30 Jul 2023 13:09:26 -0700
In-Reply-To: <ZMXIi+HC3uFQyvGK@aschofie-mobl2>
References: <20230726073421.2452-1-raghuhack78@gmail.com>
         <20230726073421.2452-3-raghuhack78@gmail.com>
         <ZMXIi+HC3uFQyvGK@aschofie-mobl2>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: jf6edj6agmfhkqjuihobpbi8y3n3153w
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: E055420010
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18+cDEPJpffcih+mU6D8ESFeoFIhNVo0w4=
X-HE-Tag: 1690747767-968619
X-HE-Meta: U2FsdGVkX1/Qj55gyDmRDC+wgo4dOuGUxV6Bw9W20Pj4+TsbuvdqlOTXqa44eS8qjtzC2qNAe9SH44uIC8IzIWlfxdhvqva4K/uqrfQeHct4SbnGOkEXiHf+qBknIy+9hVpTAMsJkfN/KcNDYR5OBrackmHk+RvPwkZKSmT+C0W7xZfoO9xgO2mfZrubWTJwexS+HLxz5MoWNfF4PjycgnGxnBE7RmuNjIQceowGfEKfkQNAcbpzJGYfrTucZTVBHuOn2kTmypmF7nJfh6KN+F8jkWJYDLYsxkyRuU6/X5MeJJs4zz0+htLeIpP37lTeA0zmug19PUJWac0HNghsWfIW1kvCXuzlMG7Fp7WV+dlxCsILcjRYlA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-07-29 at 19:18 -0700, Alison Schofield wrote:
> On Wed, Jul 26, 2023 at 07:34:21AM +0000, Raghu Halharvi wrote:
> > Issue found with checkpatch
> > 
> > The else section here is redundant after return statement, removing it.
> > Sanity and correctness is not affected due to this fix.
> > 
> > Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
> 
> 
> > ---
> >  drivers/cxl/core/region.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index e115ba382e04..bfd3b13dd2c1 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -133,11 +133,11 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
> >  				&cxlr->dev,
> >  				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
> >  			return 0;
> > -		} else {
> > -			dev_err(&cxlr->dev,
> > -				"Failed to synchronize CPU cache state\n");
> > -			return -ENXIO;
> >  		}
> > +
> > +		dev_err(&cxlr->dev,
> > +			"Failed to synchronize CPU cache state\n");
> > +		return -ENXIO;
> >  	}
> >  
> >  	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> > -- 
> > 2.39.2
> > 

My preference would be for this function to be something like:
---
static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
{
	if (cpu_cache_has_invalidate_memregion()) {
		cpu_cache_invalidate_memregion(IORES_DESC_CXL);
		return 0;
	}

	if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
		dev_warn_once(&cxlr->dev,
			      "Bypassing cpu_cache_invalidate_memregion() for testing!\n");
		return 0;
	}

	dev_err(&cxlr->dev, "Failed to synchronize CPU cache state\n");
	return -ENXIO;
}

