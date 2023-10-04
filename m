Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD737B9845
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbjJDWlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244088AbjJDWlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:41:32 -0400
X-Greylist: delayed 2787 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Oct 2023 15:39:06 PDT
Received: from mx0a-00105401.pphosted.com (mx0a-00105401.pphosted.com [67.231.144.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A26510DA;
        Wed,  4 Oct 2023 15:39:06 -0700 (PDT)
Received: from pps.filterd (m0346910.ppops.net [127.0.0.1])
        by mx0a-00105401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 394KYr3g023909;
        Wed, 4 Oct 2023 21:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=POD051818; bh=EsUaH+QXqx08w4OvwQkE3ZN5ZLh3Pr9zHpexBAT5Yuo=;
 b=DLIZ/ojA8yDB8C/rQFvCRvd2b3n0DAZt/xPvyMPd00mr3ahtQJ39qa69Pmv3HjToqVMv
 W3aju7VJHzKs0WQ17JjXLkspTkRDMz0FtjEqTEh1cHR/EEGnUf8NrF9gegsVgBTA51Hy
 /2f3CZQg/edOqojR/9yJGxXTSiOxHimf5nhh8DfROWRdQDlLGkBeV0uMxYsDg3PYG4Zt
 +nf+WefMEXdR9Y2GVJVl/jvk7n68Z2lKlvlxj4BZnuioDmYQrD5QZPJoaoSByhB4p/cV
 I0eHIZblDRbhCJig1ZV3XBBAcUsXrxcAGsPSqOZsXVjRO+GWzb6q55rVtUw+Ylqr/Vtw wQ== 
Received: from xusxph008rp050.rtx.com (xusxph008rp050.rtx.com [128.13.124.147])
        by mx0a-00105401.pphosted.com (PPS) with ESMTPS id 3tgxt60txd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 21:52:22 +0000
Received: from xusxph009rp020.corp.ray.com ([128.13.125.224])
        by xusxph008rp050.rtx.com (8.17.1.19/8.17.1.19) with ESMTPS id 394LqK3d027794
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 21:52:21 GMT
Received: from crulimr02.rockwellcollins.com (snat-utc-mailhub.rockwellcollins.com [10.172.224.19])
        by xusxph009rp020.corp.ray.com (8.17.1.19/8.17.1.19) with ESMTPS id 394LqKlT032673
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 4 Oct 2023 21:52:20 GMT
X-Received: from bspbox.kirk (kirk.rockwellcollins.lab [10.148.204.208])
        by crulimr02.rockwellcollins.com (Postfix) with ESMTPS id 2F1FD6089B;
        Wed,  4 Oct 2023 16:52:20 -0500 (CDT)
Date:   Wed, 4 Oct 2023 21:52:19 +0000
From:   Brandon Maier <brandon.maier@collins.com>
To:     Yoann Congal <yoann.congal@smile.fr>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3] kconfig: avoid an infinite loop in
 oldconfig/syncconfig
Message-ID: <wikmpahnfwa3bgei7mglda53l6smzieinlogvvswlwhw6l7uaw@a4qgkxqjkz4h>
References: <20230912154811.1338390-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912154811.1338390-1-yoann.congal@smile.fr>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_13,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040161
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=970 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040161
X-Proofpoint-ORIG-GUID: ekNlY0Cfg8nDfYSni1zSyTpMdcPscdUE
X-Proofpoint-GUID: ekNlY0Cfg8nDfYSni1zSyTpMdcPscdUE
X-Proofpoint-Spam-Details: rule=outbound_default_notspam policy=outbound_default score=0 clxscore=1011
 adultscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoann,

We encountered the same issue in U-Boot under Buildroot. I verified that
this patch fixes the issue, causing Kconfig to exit out instead of
infinitely looping. Thanks for the fix.

Tested-by: Brandon Maier <brandon.maier@collins.com>

On Tue, Sep 12, 2023 at 05:48:11PM +0200, Yoann Congal wrote:
> Exit on error when asking for value and reading stdin returns an error
> (mainly if it has reached EOF or is closed).
>
> This infinite loop happens in particular for hex/int configs without an
> explicit default value.
>
> Previously, this case would loop:
> * oldconfig prompts for the value but stdin has reached EOF
> * It gets the global default value : an empty string
> * This is not a valid hex/int value so it prompts again, hence the
>   infinite loop.
>
> This case happens with a configuration like this (a hex config without a
> valid default value):
>   config TEST_KCONFIG
>        hex "Test KConfig"
>        # default 0x0
>
> And using:
>   make oldconfig < /dev/null
>
> This was discovered when working on Yocto bug[0] on a downstream
> kconfig user (U-boot)
>
> [0]: https://bugzilla.yoctoproject.org/show_bug.cgi?id=14136
>
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
> v2->v3:
>  * Simplify the patch by fusing comments of :
>    * Masahiro Yamada : Exit as soon as reading stdin hits an error
>    * Randy Dunlap : Display the name of the currently read symbol
>
> v1->v2:
>  * Improve coding style
>  * Put more info in the commit message
>
>  scripts/kconfig/conf.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
> index 33d19e419908b..68f0c649a805e 100644
> --- a/scripts/kconfig/conf.c
> +++ b/scripts/kconfig/conf.c
> @@ -74,13 +74,17 @@ static void strip(char *str)
>  }
>
>  /* Helper function to facilitate fgets() by Jean Sacren. */
> -static void xfgets(char *str, int size, FILE *in)
> +static int xfgets(char *str, int size, FILE *in)
>  {
> +	int ret = 0;
> +
>  	if (!fgets(str, size, in))
> -		fprintf(stderr, "\nError in reading or end of file.\n");
> +		ret = -1;
>
>  	if (!tty_stdio)
>  		printf("%s", str);
> +
> +	return ret;
>  }
>
>  static void set_randconfig_seed(void)
> @@ -339,7 +343,10 @@ static int conf_askvalue(struct symbol *sym, const char *def)
>  		/* fall through */
>  	default:
>  		fflush(stdout);
> -		xfgets(line, sizeof(line), stdin);
> +		if (xfgets(line, sizeof(line), stdin) != 0) {
> +			fprintf(stderr, "Error while reading value of symbol \"%s\"\n", sym->name);
> +			exit(1);
> +		}
>  		break;
>  	}
>
> @@ -521,7 +528,11 @@ static int conf_choice(struct menu *menu)
>  			/* fall through */
>  		case oldaskconfig:
>  			fflush(stdout);
> -			xfgets(line, sizeof(line), stdin);
> +			if (xfgets(line, sizeof(line), stdin) != 0) {
> +				fprintf(stderr, "Error while reading value of symbol \"%s\"\n",
> +						sym->name);
> +				exit(1);
> +			}
>  			strip(line);
>  			if (line[0] == '?') {
>  				print_help(menu);
> --
> 2.30.2
>
