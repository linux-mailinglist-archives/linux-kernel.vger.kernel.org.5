Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C6276CDC4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjHBNBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjHBNBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:01:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96287268F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:01:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso6194585e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690981303; x=1691586103;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxcPQeW9fzPhjHoLIhMXQEyGNsMbVWBtLHyC7kVUcRQ=;
        b=1cOzbWtGnNr0oq5YpBkDSPGdXvaaNH5jbOiZt4CfrJ8vLq6b5kf2pI/awLh/qtwrDG
         sA5qYI2g8HGUgxzh6+wiluabf6nUK/HZZ31rXNJI3dMfA51kG2rW7EYMRq3P96GORVUN
         q7bi/lCnwxX1hXHT6AZwwK+BAo0oR3feS6AscZ7CTpMXou5qWIPqjc4pyr563ZFTPQBK
         /hFHhBRbCquIAo9+kX2zyGltTPNrkzeKFNVphVxa3Om/H2zc6kycNs0oxMjxu0aeB/jN
         qn6ZzgT8Tib+WxdWFZ6jD/H+ke9ijzZH6ODW+C6Hm+QpjvykHCi3Z7PkWfe2bSeXkWXi
         mRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690981303; x=1691586103;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxcPQeW9fzPhjHoLIhMXQEyGNsMbVWBtLHyC7kVUcRQ=;
        b=abSrHrbMFUTlQgozRTMKfBjti6F0ceETFD8DXnGDxLkFaaBUa8FYkDYa9rrlOa9SvG
         rOCqAmLbYiZwYNbdJSLoWaxQHNneG4N/jB/HVVj1ylc5x3kITC2gptVveKL50G4EyHmk
         EHTd2L31Wg+OHRdTpvR0mgYyGVW5hoZKeGE8B78L9TB00pTNGahrB6wEGDRJ6ttwhP7l
         cbEuNRxOT4NiA6iolOIn60FTk05Ra50neZL8dTHb6MNeII72cwIxx/j9GNgV0JK387P4
         OBU6MZ6ed3wpQomUw0mv4f7dD4y8M/v4VnumqoT3ba9ZsZvtjtDow6UygpIkUTnCHnMC
         I9GQ==
X-Gm-Message-State: ABy/qLZ0KsuKEZATH54xifkAoGgDAEddt8mZVMmE5A0O1qEzlOeLsb8E
        rDurexLCxwVUpZfrVsfk03K9rN3KCnUvU+W7w010tA==
X-Google-Smtp-Source: APBJJlFjjfgcyEYCX0PK9ne2jwjGXvD5H3g617zp2BBhW8ltl39euxhlq/1IV8SvE8lviuvJMHIRaQ==
X-Received: by 2002:a05:600c:1d9e:b0:3fe:20f1:fb2 with SMTP id p30-20020a05600c1d9e00b003fe20f10fb2mr5198634wms.6.1690981303368;
        Wed, 02 Aug 2023 06:01:43 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
        by smtp.gmail.com with ESMTPSA id p22-20020a7bcc96000000b003fbdd5d0758sm1609096wma.22.2023.08.02.06.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 06:01:42 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff LaBundy <jeff@labundy.com>
Subject: Re: [PATCH 03/22] Input: iqs269a - use device core to create
 driver-specific device attributes
In-Reply-To: <20230729005133.1095051-3-dmitry.torokhov@gmail.com>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
 <20230729005133.1095051-3-dmitry.torokhov@gmail.com>
Date:   Wed, 02 Aug 2023 15:01:42 +0200
Message-ID: <87cz0538eh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ven., juil. 28, 2023 at 17:51, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Instead of creating driver-specific device attributes with
> devm_device_add_group() have device core do this by setting up dev_groups
> pointer in the driver structure.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/misc/iqs269a.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/input/misc/iqs269a.c b/drivers/input/misc/iqs269a.c
> index c0a085639870..3c636c75e8a1 100644
> --- a/drivers/input/misc/iqs269a.c
> +++ b/drivers/input/misc/iqs269a.c
> @@ -1586,10 +1586,7 @@ static struct attribute *iqs269_attrs[] = {
>  	&dev_attr_ati_trigger.attr,
>  	NULL,
>  };
> -
> -static const struct attribute_group iqs269_attr_group = {
> -	.attrs = iqs269_attrs,
> -};
> +ATTRIBUTE_GROUPS(iqs269);
>  
>  static const struct regmap_config iqs269_regmap_config = {
>  	.reg_bits = 8,
> @@ -1671,10 +1668,6 @@ static int iqs269_probe(struct i2c_client *client)
>  		return error;
>  	}
>  
> -	error = devm_device_add_group(&client->dev, &iqs269_attr_group);
> -	if (error)
> -		dev_err(&client->dev, "Failed to add attributes: %d\n", error);
> -
>  	return error;
>  }
>  
> @@ -1743,6 +1736,7 @@ MODULE_DEVICE_TABLE(of, iqs269_of_match);
>  static struct i2c_driver iqs269_i2c_driver = {
>  	.driver = {
>  		.name = "iqs269a",
> +		.dev_groups = iqs269_groups,
>  		.of_match_table = iqs269_of_match,
>  		.pm = pm_sleep_ptr(&iqs269_pm),
>  	},
> -- 
> 2.41.0.487.g6d72f3e995-goog
