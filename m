Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ADF7B6744
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbjJCLKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjJCLKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:10:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3C4EAC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:10:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39DB61042
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:11:14 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8334D3F762
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:10:35 -0700 (PDT)
Date:   Tue, 3 Oct 2023 12:10:32 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kai Uwe Broulik <foss-linux@broulik.de>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2] drm: panel-orientation-quirks: Add quirk for One Mix
 2S
Message-ID: <ZRv2qLU_zHqCLJJs@e110455-lin.cambridge.arm.com>
References: <20231001114710.336172-1-foss-linux@broulik.de>
 <4a86bbd4-4798-b81b-8f08-b2c8c125999d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a86bbd4-4798-b81b-8f08-b2c8c125999d@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 02:21:43PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 10/1/23 13:47, Kai Uwe Broulik wrote:
> > The One Mix 2S is a mini laptop with a 1200x1920 portrait screen
> > mounted in a landscape oriented clamshell case. Because of the too
> > generic DMI strings this entry is also doing bios-date matching.
> > 
> > Signed-off-by: Kai Uwe Broulik <foss-linux@broulik.de>
> > ---
> > Changes since v1:
> > * Got two more BIOS dates reported
> 
> Thanks, patch still looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> drm-misc maintainers, I'm currently traveling can
> one of you push this to drm-misc-fixes please?

Done. Have a safe trip.

Best regards,
Liviu

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> > 
> >  drivers/gpu/drm/drm_panel_orientation_quirks.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > index 0cb646cb04ee..d5c15292ae93 100644
> > --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> > @@ -38,6 +38,14 @@ static const struct drm_dmi_panel_orientation_data gpd_micropc = {
> >  	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
> >  };
> >  
> > +static const struct drm_dmi_panel_orientation_data gpd_onemix2s = {
> > +	.width = 1200,
> > +	.height = 1920,
> > +	.bios_dates = (const char * const []){ "05/21/2018", "10/26/2018",
> > +		"03/04/2019", NULL },
> > +	.orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP,
> > +};
> > +
> >  static const struct drm_dmi_panel_orientation_data gpd_pocket = {
> >  	.width = 1200,
> >  	.height = 1920,
> > @@ -401,6 +409,14 @@ static const struct dmi_system_id orientation_data[] = {
> >  		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "LTH17"),
> >  		},
> >  		.driver_data = (void *)&lcd800x1280_rightside_up,
> > +	}, {	/* One Mix 2S (generic strings, also match on bios date) */
> > +		.matches = {
> > +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Default string"),
> > +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Default string"),
> > +		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Default string"),
> > +		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Default string"),
> > +		},
> > +		.driver_data = (void *)&gpd_onemix2s,
> >  	},
> >  	{}
> >  };
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
