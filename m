Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F8E80A18E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573646AbjLHKxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjLHKx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:53:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF61210CF;
        Fri,  8 Dec 2023 02:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702032814; x=1733568814;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Evl6/fV9FvnpjIv/giDVb7xclTPtiZRexx5A59bvzq8=;
  b=m0XlDc7lSAg0qKBg3Bd8Bw1AyYK7LBHRJJH66EnlEVE2BRYkcMNsmwt7
   my61VLOgR7yb6waH/W/2Oyz4gEa3hfMxbNHVsKgKP1VM/EKAqUUDZl+/2
   yL8xqz3aclx8zpcK7JF56aOhh0ETlM7EEgIZyUB2RYLV67FApLS2XnunW
   cf318pzh+Hx0BI2S6zmuRaiNb7h+wuFo3LQkjlOkNbr29VCySCduxuFEB
   BlCp4Ve/mh30QNGCtX00FYJXd4VQ28+QHtghLuxqugHbMiBNTFFgNadnq
   MpihRax58wA8UHK616RkX8X3z077kM24EqLe+DeHkC4G2mHb+6QvDHXMf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="391560942"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="391560942"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 02:53:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842560542"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="842560542"
Received: from smatua-mobl.ger.corp.intel.com ([10.251.223.110])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 02:53:32 -0800
Date:   Fri, 8 Dec 2023 12:53:29 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Vishnu Sankar <vishnuocv@gmail.com>
cc:     hdegoede@redhat.com, mpearson-lenovo@squebb.ca,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, markgross@kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: fix for incorrect fan
 reporting on some ThinkPad systems
In-Reply-To: <20231206162003.92010-1-vishnuocv@gmail.com>
Message-ID: <2ae27a1b-a472-8a57-994e-f016cc25dafc@linux.intel.com>
References: <20231206162003.92010-1-vishnuocv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023, Vishnu Sankar wrote:

Hi Vishnu,

Thanks for the patch.

> Some ThinkPad systems ECFW use non-standard addresses for fan control
> and reporting. This patch adds support for such ECFW so that it can report
> the correct fan values.
> Tested on Thinkpads L13 Yoga Gen 2 and X13 Yoga Gen 2.
> 
> Co-developed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>

If Mark wrote any lines, his Signed-off-by is also required before yours,
as per Documentation/process/5.Posting.rst, this is a hard requirement. 

If he only helped towards the right direction/solution but provided no 
code, I recommend using Suggested-by tag instead.

> ---
>  drivers/platform/x86/thinkpad_acpi.c | 88 ++++++++++++++++++++++++----
>  1 file changed, 76 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index d0b5fd4137bc..51ec20e07b23 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -7950,6 +7950,11 @@ static struct ibm_struct volume_driver_data = {
>   * 	but the ACPI tables just mention level 7.
>   */
>  
> +#define FAN_RPM_CAL_CONST 491520	/* FAN RPM calculation offset for some non-standard ECFW */
> +
> +#define FAN_NS_CTRL_STATUS	BIT(2)		/* Bit which determines control is enabled or not */
> +#define FAN_NS_CTRL		BIT(4)		/* Bit which determines control is by host or EC */
> +
>  enum {					/* Fan control constants */
>  	fan_status_offset = 0x2f,	/* EC register 0x2f */
>  	fan_rpm_offset = 0x84,		/* EC register 0x84: LSB, 0x85 MSB (RPM)
> @@ -7957,6 +7962,11 @@ enum {					/* Fan control constants */
>  	fan_select_offset = 0x31,	/* EC register 0x31 (Firmware 7M)
>  					   bit 0 selects which fan is active */
>  
> +	fan_status_offset_ns = 0x93,	/* Special status/control offset for non-standard EC Fan1 */
> +	fan2_status_offset_ns = 0x96,	/* Special status/control offset for non-standard EC Fan2 */
> +	fan_rpm_status_ns = 0x95,	/* Special offset for Fan1 RPM status for non-standard EC */
> +	fan2_rpm_status_ns = 0x98,	/* Special offset for Fan2 RPM status for non-standard EC */
> +
>  	TP_EC_FAN_FULLSPEED = 0x40,	/* EC fan mode: full speed */
>  	TP_EC_FAN_AUTO	    = 0x80,	/* EC fan mode: auto fan control */
>  
> @@ -7967,6 +7977,7 @@ enum fan_status_access_mode {
>  	TPACPI_FAN_NONE = 0,		/* No fan status or control */
>  	TPACPI_FAN_RD_ACPI_GFAN,	/* Use ACPI GFAN */
>  	TPACPI_FAN_RD_TPEC,		/* Use ACPI EC regs 0x2f, 0x84-0x85 */
> +	TPACPI_FAN_RD_TPEC_NS,		/* Use non-standard ACPI EC regs (eg: L13 Yoga gen2 etc.) */
>  };
>  
>  enum fan_control_access_mode {
> @@ -7994,6 +8005,8 @@ static u8 fan_control_desired_level;
>  static u8 fan_control_resume_level;
>  static int fan_watchdog_maxinterval;
>  
> +static bool fan_with_ns_addr;
> +
>  static struct mutex fan_mutex;
>  
>  static void fan_watchdog_fire(struct work_struct *ignored);
> @@ -8123,6 +8136,15 @@ static int fan_get_status(u8 *status)
>  		}
>  
>  		break;
> +	case TPACPI_FAN_RD_TPEC_NS:

There's a big comment about FAN ACCESS MODES and now you seem to be adding 
another one. Can you please check if there would be something useful to 
add/edit in that big comment because of the addition of 
TPACPI_FAN_RD_TPEC_NS.

> +		/* Default mode is AUTO which means controlled by EC */
> +		if (unlikely(!acpi_ec_read(fan_status_offset_ns, &s)))

I'm skeptical that all these unlikely/likely() are useful. Some might even 
be harmful if e.g. is some error condition keeps repeating itself and 
the particular if handling that is marked with unlikely().

I know the code in that file is littered with them already but it would 
be better to add into that, IMO.

> +			return -EIO;
> +
> +		if (likely(status))
> +			*status = s;
> +
> +		break;
>  
>  	default:
>  		return -ENXIO;
> @@ -8139,7 +8161,8 @@ static int fan_get_status_safe(u8 *status)
>  	if (mutex_lock_killable(&fan_mutex))
>  		return -ERESTARTSYS;
>  	rc = fan_get_status(&s);
> -	if (!rc)
> +	/* NS EC doesn't have register with level settings */
> +	if (!rc && !fan_with_ns_addr)
>  		fan_update_desired_level(s);
>  	mutex_unlock(&fan_mutex);
>  
> @@ -8166,7 +8189,13 @@ static int fan_get_speed(unsigned int *speed)
>  
>  		if (likely(speed))
>  			*speed = (hi << 8) | lo;
> +		break;
> +	case TPACPI_FAN_RD_TPEC_NS:
> +		if (unlikely(!acpi_ec_read(fan_rpm_status_ns, &lo)))
> +			return -EIO;
>  
> +		if (likely(speed))
> +			*speed = lo ? FAN_RPM_CAL_CONST / lo : 0;
>  		break;
>  
>  	default:
> @@ -8178,7 +8207,7 @@ static int fan_get_speed(unsigned int *speed)
>  
>  static int fan2_get_speed(unsigned int *speed)
>  {
> -	u8 hi, lo;
> +	u8 hi, lo, status;
>  	bool rc;
>  
>  	switch (fan_status_access_mode) {
> @@ -8194,7 +8223,21 @@ static int fan2_get_speed(unsigned int *speed)
>  
>  		if (likely(speed))
>  			*speed = (hi << 8) | lo;
> +		break;
>  
> +	case TPACPI_FAN_RD_TPEC_NS:
> +		rc = !acpi_ec_read(fan2_status_offset_ns, &status);
> +		if (rc)
> +			return -EIO;
> +		if (!(status & FAN_NS_CTRL_STATUS)) {
> +			pr_info("fan fan2 control not supported\n");

Perhaps "fan2 control ..." would be enough or perhaps "secondary fan 
control ..." (the latter matching fan_init() printouts) ?

> +			return -EIO;
> +		}
> +		rc = !acpi_ec_read(fan2_rpm_status_ns, &lo);
> +		if (rc)
> +			return -EIO;
> +		if (likely(speed))
> +			*speed = lo ? FAN_RPM_CAL_CONST / lo : 0;
>  		break;
>  
>  	default:
> @@ -8697,6 +8740,7 @@ static const struct attribute_group fan_driver_attr_group = {
>  #define TPACPI_FAN_2FAN		0x0002		/* EC 0x31 bit 0 selects fan2 */
>  #define TPACPI_FAN_2CTL		0x0004		/* selects fan2 control */
>  #define TPACPI_FAN_NOFAN	0x0008		/* no fan available */
> +#define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
>  
>  static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>  	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
> @@ -8715,6 +8759,8 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>  	TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (2nd gen) */
>  	TPACPI_Q_LNV3('N', '3', '0', TPACPI_FAN_2CTL),	/* P15 (1st gen) / P15v (1st gen) */
>  	TPACPI_Q_LNV3('N', '3', '7', TPACPI_FAN_2CTL),  /* T15g (2nd gen) */
> +	TPACPI_Q_LNV3('R', '1', 'F', TPACPI_FAN_NS),	/* L13 Yoga Gen 2 */
> +	TPACPI_Q_LNV3('N', '2', 'U', TPACPI_FAN_NS),	/* X13 Yoga Gen 2*/
>  	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
>  };
>  
> @@ -8749,6 +8795,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
>  		return -ENODEV;
>  	}
>  
> +	if (quirks & TPACPI_FAN_NS) {
> +		pr_info("ECFW with non-standard fan reg control found\n");
> +		fan_with_ns_addr = 1;
> +		/* Fan ctrl support from host is undefined for now */
> +		tp_features.fan_ctrl_status_undef = 1;
> +	}
> +
>  	if (gfan_handle) {
>  		/* 570, 600e/x, 770e, 770x */
>  		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
> @@ -8756,11 +8809,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
>  		/* all other ThinkPads: note that even old-style
>  		 * ThinkPad ECs supports the fan control register */
>  		if (likely(acpi_ec_read(fan_status_offset,
> -					&fan_control_initial_status))) {
> +					&fan_control_initial_status)) || fan_with_ns_addr) {

So if we know the addresses are non-standard, why is the acpi_ec_read 
performed at all? That is, why isn't the || logic in reverse order?

I also wonder what will fan_control_initial_status be set to in this case, 
is it garbage?

>  			int res;
>  			unsigned int speed;
>  
> -			fan_status_access_mode = TPACPI_FAN_RD_TPEC;
> +			fan_status_access_mode = fan_with_ns_addr ?
> +				TPACPI_FAN_RD_TPEC_NS : TPACPI_FAN_RD_TPEC;
> +
>  			if (quirks & TPACPI_FAN_Q1)
>  				fan_quirk1_setup();
>  			/* Try and probe the 2nd fan */
> @@ -8769,7 +8824,8 @@ static int __init fan_init(struct ibm_init_struct *iibm)
>  			if (res >= 0 && speed != FAN_NOT_PRESENT) {
>  				/* It responded - so let's assume it's there */
>  				tp_features.second_fan = 1;
> -				tp_features.second_fan_ctl = 1;
> +				/* fan control not currently available for ns ECFW */
> +				tp_features.second_fan_ctl = fan_with_ns_addr ? 0 : 1;

= !fan_with_ns_addr;

>  				pr_info("secondary fan control detected & enabled\n");
>  			} else {
>  				/* Fan not auto-detected */
> @@ -8944,6 +9000,7 @@ static int fan_read(struct seq_file *m)
>  			       str_enabled_disabled(status), status);
>  		break;
>  
> +	case TPACPI_FAN_RD_TPEC_NS:
>  	case TPACPI_FAN_RD_TPEC:
>  		/* all except 570, 600e/x, 770e, 770x */
>  		rc = fan_get_status_safe(&status);
> @@ -8958,13 +9015,20 @@ static int fan_read(struct seq_file *m)
>  
>  		seq_printf(m, "speed:\t\t%d\n", speed);
>  
> -		if (status & TP_EC_FAN_FULLSPEED)
> -			/* Disengaged mode takes precedence */
> -			seq_printf(m, "level:\t\tdisengaged\n");
> -		else if (status & TP_EC_FAN_AUTO)
> -			seq_printf(m, "level:\t\tauto\n");
> -		else
> -			seq_printf(m, "level:\t\t%d\n", status);
> +		if (fan_status_access_mode == TPACPI_FAN_RD_TPEC_NS) {
> +			/* No full speed bit in NS EC*/

Missing space. But I'd convert these two comments into a multiline one 
anyway.

> +			/* EC Auto mode is set by default. No other levels settings available*/
> +			(status & FAN_NS_CTRL) ? seq_puts(m, "level:\t\tunknown\n")
> +					: seq_puts(m, "level:\t\tauto\n");

seq_printf(m, "level:\t\t%s\n", status & FAN_NS_CTRL ? "unknown" : "auto");

> +		} else {
> +			if (status & TP_EC_FAN_FULLSPEED)
> +				/* Disengaged mode takes precedence */
> +				seq_puts(m, "level:\t\tdisengaged\n");
> +			else if (status & TP_EC_FAN_AUTO)
> +				seq_puts(m, "level:\t\tauto\n");

Please don't make an unrelated seq_printf() -> seq_puts() change in this 
patch.

> +			else
> +				seq_printf(m, "level:\t\t%d\n", status);
> +		}
>  		break;
>  
>  	case TPACPI_FAN_NONE:
> 

-- 
 i.

