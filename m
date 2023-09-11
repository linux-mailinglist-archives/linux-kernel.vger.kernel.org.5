Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14A79BBAD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbjIKVQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbjIKIXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:23:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC16EB;
        Mon, 11 Sep 2023 01:23:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1005C433C9;
        Mon, 11 Sep 2023 08:23:00 +0000 (UTC)
Message-ID: <70260067-b12e-41e2-841c-8ee019a67513@xs4all.nl>
Date:   Mon, 11 Sep 2023 10:22:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: cros-ec-cec: Add Constitution to the match
 table
Content-Language: en-US, nl
To:     Stefan Adolfsson <sadolfsson@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Reka Norman <rekanorman@chromium.org>,
        linux-media@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230911081921.3515928-1-sadolfsson@google.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230911081921.3515928-1-sadolfsson@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 10:19, Stefan Adolfsson wrote:
> From: Stefan Adolfsson <sadolfsson@chromium.org>
> 
> Constitution has two HDMI ports which support CEC:
>     Port B is EC port 0
>     Port A is EC port 1
> 
> This patch depends on "media: cros-ec-cec: Add Dibbi to the match
> table".
> 
> Signed-off-by: Stefan Adolfsson <sadolfsson@chromium.org>
> ---
> Changes in v2:
>  Use a NULL-terminated conns array for the match table entry
> 
>  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> index 21361eff50ff..85431af65224 100644
> --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> @@ -296,6 +296,7 @@ struct cec_dmi_match {
>  
>  static const char *const fizz_conns[] = { "Port B", NULL };
>  static const char *const dibbi_conns[] = { "Port D", "Port B", NULL };
> +static const char *const constitution_conns[] = { "Port B", "Port A", NULL };
>  
>  static const struct cec_dmi_match cec_dmi_match_table[] = {
>  	/* Google Fizz */
> @@ -316,6 +317,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
>  	{ "Google", "Lisbon", "0000:00:02.0", fizz_conns },
>  	/* Google Dibbi */
>  	{ "Google", "Dibbi", "0000:00:02.0", dibbi_conns },
> +	/* Google Constitution */
> +	{ "Google", "Constitution", "0000:00:02.0", constitution_conns },
>  };
>  
>  static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,

I made that change myself when I merged your v1 patch. So I just mark this
v2 as Obsolete in patchwork.

Regards,

	Hans
