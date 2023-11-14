Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10C87EB42D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjKNPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbjKNPwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:52:08 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89071BB;
        Tue, 14 Nov 2023 07:52:05 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7789577b53fso355931785a.3;
        Tue, 14 Nov 2023 07:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699977124; x=1700581924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDIsw6iCRCkkHtZUOVAOy4wE3ySOPjZG0P1Xurh3oQc=;
        b=eyFexgR4//MePD+62vo2c25tw8tysVgaXO5LiU7Dv3maN6UOeuNZ2/X+LdIxQhwihi
         EnMCclhINxv1XBm0q0JJv453y9lI/Tivol1tU6u+FDwQnhI+OFDz2erX8GBGqeY3crSz
         7agJjszweUbFT8sUVOIMnIR72b4SJb0fYYRYDay853RGBeoLc25SK5g+iCt4Q7oIgdCI
         iGSrdjmSTr0pNL4BKLMd8xzYDcbe2jal4saIKrL+NPo6VMZgtx/QOmfk6KEmoYsYdX7e
         MSlbdmcCCpXae0aIybLDUVy+vKKlM/3redz5hOT9O2XHlxD2zfxLDBKiPW6mF/QNAL/A
         KR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699977124; x=1700581924;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rDIsw6iCRCkkHtZUOVAOy4wE3ySOPjZG0P1Xurh3oQc=;
        b=tNkJLDo5z+0ai0CVbxouCNV+8GGGqrYrd38SuMZqahzTgs+2UXLAp50Hq8UOh6x/t+
         9+i8w71tPJ9lMXJr93uuYcl7/dNPQaSdZmXwVwbhRyPoJGD5xXbuTyP8yIkzd64AseWC
         WNfb2OeXsLSTbW2/EhG1oBYnkxUMoLfncagdRjFR9EFOSNz2WUtyK3uOQpqKB8m8z6Yn
         o+qxqdXJMxbXEZtXPN+sBs+8stLwqgzE9cIlhdqVDJPvDtp8uVVEnwOqGKSmovG42fLR
         MSFIbU48cUakTcVi6BkQAv2kd0mto0URfou38yWigEhB7nvc7RzywLwLDMUi+OObxt2l
         l+2Q==
X-Gm-Message-State: AOJu0YzizlfQW7p/ee1rx/kVv4NtPdz9bBuLD8E2BOB8ySEYZanH2RNi
        ZoanXiLGrYy4+TVWYEDsO64=
X-Google-Smtp-Source: AGHT+IHYgHhpQNHunVVy4tvWXY0eiuAjucuk61pdXd64PUs0P5jttrqIpT7s44OeH077F3LgTBbkYg==
X-Received: by 2002:a0c:ebcf:0:b0:66d:25f7:de15 with SMTP id k15-20020a0cebcf000000b0066d25f7de15mr2435603qvq.31.1699977124669;
        Tue, 14 Nov 2023 07:52:04 -0800 (PST)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id b11-20020a0ce88b000000b00668bb8be252sm2974542qvo.60.2023.11.14.07.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:52:04 -0800 (PST)
Date:   Tue, 14 Nov 2023 10:52:04 -0500
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Kory Maincent <kory.maincent@bootlin.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>
Message-ID: <655397a41f1bb_125ffe294aa@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231114-feature_ptp_netnext-v7-7-472e77951e40@bootlin.com>
References: <20231114-feature_ptp_netnext-v7-0-472e77951e40@bootlin.com>
 <20231114-feature_ptp_netnext-v7-7-472e77951e40@bootlin.com>
Subject: Re: [PATCH net-next v7 07/16] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kory Maincent wrote:
> Timestamping software or hardware flags are often used as a group,
> therefore adding these masks will easier future use.
> 
> I did not use SOF_TIMESTAMPING_SYS_HARDWARE flag as it is deprecated and
> not use at all.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
