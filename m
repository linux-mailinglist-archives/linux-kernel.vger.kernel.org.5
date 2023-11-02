Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473317DF8FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjKBRlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbjKBRlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:41:39 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1856191;
        Thu,  2 Nov 2023 10:41:36 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so17446711fa.0;
        Thu, 02 Nov 2023 10:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698946895; x=1699551695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BsIKUWuakJM0P+NQHmV9kFiVxREoAkLhqEdhljFcHzE=;
        b=H5kh6/3W/3R5AwpjYBjqKMzTf227Pb1tOZ7wf5pzp4BqLws0T2x/5vwyeasN5N+DA9
         Z9a4j6leHOmAiuHmUoxW5cyuqwBIE+7nlT1CwdcgXKZ21ecPRL2pcTtwNM6o0QB4dtBB
         ETDphyWxnkMbv9/RyxBuy28yMtSFdui44Atp2OtkZJbyvN6cx8Qsd8pBu0AceuDnWm6W
         cQY9DSiGBzc/6yucv7hgxMxVmbXK1bUmoJn+Xqj2Jmd22mNioTz2VOBkuZzNdQGMYzfq
         xpPgg4jo2C88oODL7R7fCgNLuHxsa7pTnTrGK5+BXg00C05xJ/bZ2gqQra1IoKFCv6Mh
         srFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698946895; x=1699551695;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsIKUWuakJM0P+NQHmV9kFiVxREoAkLhqEdhljFcHzE=;
        b=iS2jsb3pW/1BP8PneQuDnvLATiTfGwcwkv11yWw+qrdA//LFT9csOFORv5XAWKG6m/
         Tj2v2ncLMjApN81wImDNUCF1Darh4QUisccGbr4ZD4n80CzDPJ1tIReYmkj3DKII10RJ
         u3TJUr8rks3RzRLbLdZBZSkoa8D++KZqjy1iPu9l6RcRhXqdODSoOeM4NWOpe02Pi36d
         Qv9DfoeabyrHxetvDKhvO9hqgt4hd2rk+7oNCuIDnEdJFrkCuZ+IOtTbKu5mZhPNI/Mm
         BTalRa5x6Ww4nq+yJ3/PjMj9SSNczc9XCrTCO3QhNlUlpy+pbkIwCoz4MlldO8Ch+cGH
         eDoQ==
X-Gm-Message-State: AOJu0Yy/2IJ5wBynz9LKuimeVoJM4WK+kaKOy08NkeGYOqGWduJHPmwR
        9piotwbYcxgZVqR3vMCP2pY=
X-Google-Smtp-Source: AGHT+IENtA1mpDpZZhOH5Fzcpvn279NJqkgApaEtOnwzK72I7DN6xdShP3XuBPOj8axyWokJHlrufQ==
X-Received: by 2002:a2e:7411:0:b0:2bc:dcd6:97b1 with SMTP id p17-20020a2e7411000000b002bcdcd697b1mr14378173ljc.47.1698946894783;
        Thu, 02 Nov 2023 10:41:34 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id l26-20020a05600c1d1a00b004063cd8105csm3657217wms.22.2023.11.02.10.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 10:41:34 -0700 (PDT)
Message-ID: <6543df4e.050a0220.e42f1.2222@mx.google.com>
X-Google-Original-Message-ID: <ZUPfSyzUeKplgYSH@Ansuel-xps.>
Date:   Thu, 2 Nov 2023 18:41:31 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Robert Marko <robimarko@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v3 3/4] net: phy: aquantia: add firmware
 load support
References: <20231102150032.10740-1-ansuelsmth@gmail.com>
 <20231102150032.10740-3-ansuelsmth@gmail.com>
 <e632a285-9cb2-4dc9-a4a2-f57e454b8ffe@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e632a285-9cb2-4dc9-a4a2-f57e454b8ffe@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 06:37:40PM +0100, Andrew Lunn wrote:
> > +/* AQR firmware doesn't have fixed offsets for iram and dram section
> > + * but instead provide an header with the offset to use on reading
> > + * and parsing the firmware.
> > + *
> > + * AQR firmware can't be trusted and each offset is validated to be
> > + * not negative and be in the size of the firmware itself.
> > + */
> > +static inline bool aqr_fw_validate_get(size_t size, size_t offset, size_t get_size)
> > +{
> > +	return size + offset > 0 && offset + get_size <= size;
> > +}
> 
> Please don't user inline in .c files. The compiler is better at
> deciding than we are.
>

OK.

> Also, i wounder about size + offset > 0. size_t is unsigned. So they
> cannot be negative. So does this test make sense?
> 

The idea was to check case where it's subtracted too much. (example
where we check the CRC at the end of the fw) but since it's unsigned i
guess it will always be zero. I will drop. (or should i use ssize_t?)

> > +static int aqr_fw_boot(struct phy_device *phydev, const u8 *data, size_t size,
> > +		       enum aqr_fw_src fw_src)
> > +{
> > +	u16 calculated_crc, read_crc, read_primary_offset;
> > +	u32 iram_offset = 0, iram_size = 0;
> > +	u32 dram_offset = 0, dram_size = 0;
> > +	char version[VERSION_STRING_SIZE];
> > +	u32 primary_offset = 0;
> > +	int ret;
> > +
> > +	/* extract saved CRC at the end of the fw
> > +	 * CRC is saved in big-endian as PHY is BE
> > +	 */
> > +	ret = aqr_fw_get_be16(data, size - sizeof(u16), size, &read_crc);
> > +	if (ret) {
> > +		phydev_err(phydev, "bad firmware CRC in firmware\n");
> > +		return ret;
> > +	}
> 
> So if size < sizeof(u16), we get a very big positive number. The > 0
> test does nothing for you here, but the other half of the test does
> trap the issue.
> 
> So i think you can remove the > 0 test.
>

Yes that single check was done because of this, but didn't notice size_t
is unsigned and it won't ever fall in negative cases.

-- 
	Ansuel
