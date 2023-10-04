Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2087B985C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbjJDWrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjJDWrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:47:20 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B902C6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 15:47:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4064876e8b8so3497475e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 15:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1696459635; x=1697064435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WWhzfTx2zeu32T5vJxvsYkXM/9ZTkaUKm+XZEMMPRPk=;
        b=JQU5rZ7TuHQjJH+ogxkBogfbA79t4yuUaYXZnkBrFiKk7u7TjNI4iBwPoceIrH9aid
         7FwBxNxyZbSG72FL/oFbuyjgurkZZMPlkj1qrHf3QFpHOZtnqeWf18jw2uKDM0Xmlrag
         RqAmmnNJ7kXnaCbh7sSs1TMHluUiVB9jB0llxHF+HBvptToqYH9nxEjFZNmqEg/wr60K
         FDkE38dhRpXVGc+nKtp5azN85Dh8TxhQ3iWdPidG0IZCf82j2K51Le9LMG1DrJofbc4s
         XeZ+jBh/nrpeA3mNAMrLAwyXpgSTTkQSs4AEX+DM4jboOIzxeN5UUzBNXkDjPuqdY54y
         nwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696459635; x=1697064435;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWhzfTx2zeu32T5vJxvsYkXM/9ZTkaUKm+XZEMMPRPk=;
        b=jf9Eoi9kaFYUoi/ildgpyeMXzYKNE2U3UM59xxk4alBTujh3JqVpbdSydD/002cpsA
         o7Kk5bra2E+eJk0kOOLZN2s1uiO1on+zD8V9pQeJ16yfwxx1BfHwE/w87Mm2dJ7CMMQy
         Vg9gEpJJ3NcJevXVyuZlXV99rjwKMpstFo3LMDJJzrLgmJx0r9ix771YAGXzC+QTAhD4
         PsgayHB9YzWZgxSQRcpcMdOHpI+wX37m3nwqP3m3m46i934fa5QpaHtEmwUBwbsGOuSV
         wUue/xNqeG6E8HGmdshAvDR8JPEYDLTTm55NxJ6FHcgKPRo6AK+K214bChoTmBgb8cro
         ihpg==
X-Gm-Message-State: AOJu0YyOTGCwIh0xiX/2vkloKUheZvXAZ7y5dqzft6K8mCbExQpEqfMN
        DW0gBEDjr9wzyt5B8N4HD5QMlw==
X-Google-Smtp-Source: AGHT+IFlBT44f1p61H0a8CKaBCtUqmYtq3IyCYd7PF4YEV7diALOPFXCjpGvHF60gomfWy16BOqsPw==
X-Received: by 2002:a7b:c5c9:0:b0:405:40ab:7693 with SMTP id n9-20020a7bc5c9000000b0040540ab7693mr3321564wmk.31.1696459634588;
        Wed, 04 Oct 2023 15:47:14 -0700 (PDT)
Received: from [192.168.0.23] ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d6746000000b00318147fd2d3sm209198wrw.41.2023.10.04.15.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 15:47:14 -0700 (PDT)
Message-ID: <bb3d2b39-0b3b-09cf-b98f-1c8bbdb26dd7@smile.fr>
Date:   Thu, 5 Oct 2023 00:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] kconfig: avoid an infinite loop in
 oldconfig/syncconfig
Content-Language: en-US
To:     Brandon Maier <brandon.maier@collins.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20230912154811.1338390-1-yoann.congal@smile.fr>
 <wikmpahnfwa3bgei7mglda53l6smzieinlogvvswlwhw6l7uaw@a4qgkxqjkz4h>
From:   Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <wikmpahnfwa3bgei7mglda53l6smzieinlogvvswlwhw6l7uaw@a4qgkxqjkz4h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 23:52, Brandon Maier wrote:
> Hi Yoann,

Hi,

> We encountered the same issue in U-Boot under Buildroot. I verified that
> this patch fixes the issue, causing Kconfig to exit out instead of
> infinitely looping. Thanks for the fix.

Awesome! I've also found this on U-boot (but under Yocto).
I planned to get this merged here in kbuild then U-boot downstream and then Yocto.

Please CC me if you try to do something with this patch in Buildroot :)

> Tested-by: Brandon Maier <brandon.maier@collins.com>

Thanks!
 
> On Tue, Sep 12, 2023 at 05:48:11PM +0200, Yoann Congal wrote:
>> Exit on error when asking for value and reading stdin returns an error
>> (mainly if it has reached EOF or is closed).
>>
>> This infinite loop happens in particular for hex/int configs without an
>> explicit default value.
>>
>> Previously, this case would loop:
>> * oldconfig prompts for the value but stdin has reached EOF
>> * It gets the global default value : an empty string
>> * This is not a valid hex/int value so it prompts again, hence the
>>   infinite loop.
>>
>> This case happens with a configuration like this (a hex config without a
>> valid default value):
>>   config TEST_KCONFIG
>>        hex "Test KConfig"
>>        # default 0x0
>>
>> And using:
>>   make oldconfig < /dev/null
>>
>> This was discovered when working on Yocto bug[0] on a downstream
>> kconfig user (U-boot)
>>
>> [0]: https://bugzilla.yoctoproject.org/show_bug.cgi?id=14136
>>
>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>> ---
>> v2->v3:
>>  * Simplify the patch by fusing comments of :
>>    * Masahiro Yamada : Exit as soon as reading stdin hits an error
>>    * Randy Dunlap : Display the name of the currently read symbol
>>
>> v1->v2:
>>  * Improve coding style
>>  * Put more info in the commit message
>>
>>  scripts/kconfig/conf.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
>> index 33d19e419908b..68f0c649a805e 100644
>> --- a/scripts/kconfig/conf.c
>> +++ b/scripts/kconfig/conf.c
>> @@ -74,13 +74,17 @@ static void strip(char *str)
>>  }
>>
>>  /* Helper function to facilitate fgets() by Jean Sacren. */
>> -static void xfgets(char *str, int size, FILE *in)
>> +static int xfgets(char *str, int size, FILE *in)
>>  {
>> +	int ret = 0;
>> +
>>  	if (!fgets(str, size, in))
>> -		fprintf(stderr, "\nError in reading or end of file.\n");
>> +		ret = -1;
>>
>>  	if (!tty_stdio)
>>  		printf("%s", str);
>> +
>> +	return ret;
>>  }
>>
>>  static void set_randconfig_seed(void)
>> @@ -339,7 +343,10 @@ static int conf_askvalue(struct symbol *sym, const char *def)
>>  		/* fall through */
>>  	default:
>>  		fflush(stdout);
>> -		xfgets(line, sizeof(line), stdin);
>> +		if (xfgets(line, sizeof(line), stdin) != 0) {
>> +			fprintf(stderr, "Error while reading value of symbol \"%s\"\n", sym->name);
>> +			exit(1);
>> +		}
>>  		break;
>>  	}
>>
>> @@ -521,7 +528,11 @@ static int conf_choice(struct menu *menu)
>>  			/* fall through */
>>  		case oldaskconfig:
>>  			fflush(stdout);
>> -			xfgets(line, sizeof(line), stdin);
>> +			if (xfgets(line, sizeof(line), stdin) != 0) {
>> +				fprintf(stderr, "Error while reading value of symbol \"%s\"\n",
>> +						sym->name);
>> +				exit(1);
>> +			}
>>  			strip(line);
>>  			if (line[0] == '?') {
>>  				print_help(menu);
>> --
>> 2.30.2
>>

-- 
Yoann Congal
Smile ECS - Tech Expert
