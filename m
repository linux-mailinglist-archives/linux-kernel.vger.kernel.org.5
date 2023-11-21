Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6967F2CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjKUMQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjKUMQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:16:06 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C823D131
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:16:02 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso3499070e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700568961; x=1701173761; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4WQYH8wKFCCHTXrK1Zk61Xzuiy6SVyBtq7SxIFkJbxM=;
        b=ng2oXt28vfppNsmNB4Dj7gmk7MlqMR8lhKHHIX5I77ZKGGgOvMBiQ9jTdTbudN8ArH
         5cZjW/HlP7BSZvbNl9FTr9k+zdDFC7lVEGmNPRm5L0aBLhDslPc/0FOnpvE7qONnBS56
         vqG21Doz0SonMSXUxj6LHs3Fton+AN9/4v6who6YOq2TAbRP7uVt5LfcTZDHBAOvhiM5
         bf0/eTlCf+eq3IvXphgCTSVj3CGMp9o2SDtFCK7/gsClHBkxNkNfBnY7A8sjEZGOlJjO
         sIrsMmEBEPrW02jo3HGkUOu0DYOhwG4SUcqa/vJnZiGMtlE/5wQVlg2BuaJ/IR0l5pYM
         Gtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700568961; x=1701173761;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WQYH8wKFCCHTXrK1Zk61Xzuiy6SVyBtq7SxIFkJbxM=;
        b=j/ZFttJ1ektdIRqAowz+NxGxz1uaona7C/JN/VwM38htfb5uQYGZp6Enwg6xxfL8wc
         0uM0z5sGjcN5SgsKQLM6znje7TSUc4DJ2ZrCxg1+vpLILEqAw2taKsDvBJ+rWqsMJt67
         ISy3rDz8SBsXCdtu5aHQ9F8av3Sb23YX9uXksZJ6iIuR8Yyd0pv0piewo4DpSokXY+Fp
         m144Rpk3ntjTrM/Gi0vZ0jPSJKQPpGaIq2NTWS9UH+ggqqsW386RCN8iih6BEPkL/vXv
         qm6CqNTIKNdsvQpKypjKdi5uoJBczeA25pIf9tCC08s4MNfDT6znFHomSG983BdWWTqr
         e6Zw==
X-Gm-Message-State: AOJu0YwWMxuTK4RKKV7g+76qDbD5hvthO/wiDwZkzBmfSd5sjvUarun8
        hibRlBdxbTE5Tm9pQ1NClK50rlU797tAhwMo5f8=
X-Google-Smtp-Source: AGHT+IEepWFvQt+GirrHSzzGQDkkCiU19dN1cDmr4WpdLO6JYl6Ytum1mSIuXIPZjxIFQiUFKDw9/M8JG7B1ilp71nM=
X-Received: by 2002:a19:7019:0:b0:509:faef:82f1 with SMTP id
 h25-20020a197019000000b00509faef82f1mr7074547lfc.26.1700568960539; Tue, 21
 Nov 2023 04:16:00 -0800 (PST)
MIME-Version: 1.0
Reply-To: razumkoykhailo@gmail.com
Sender: stedoni745@gmail.com
Received: by 2002:a05:6022:b193:b0:49:2c8f:1552 with HTTP; Tue, 21 Nov 2023
 04:15:59 -0800 (PST)
From:   "Mr.Razum Khailo" <razumkoykhailo@gmail.com>
Date:   Tue, 21 Nov 2023 04:15:59 -0800
X-Google-Sender-Auth: uvSiFkHA2nsuJ3PvfYqoVH6CWFU
Message-ID: <CAAWQ0g6N4ZAbfiQSwMwY+EoL2Ose+NVZDoU9uXuP_+fE6i=xXw@mail.gmail.com>
Subject: Greetings from Ukraine,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,MILLION_USD,
        MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:143 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [razumkoykhailo[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [stedoni745[at]gmail.com]
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        *  2.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings from Ukraine,

Mr. Razumkov Mykhailo, an entrepreneur businessman from Odessa
Ukraine. Within a year plus some months now, more than 8.2 million
people around the cities of my country Ukraine have been evacuated to
a safe location and out of the country, most especially children with
their parents, nursing mothers and pregnant women, and those who have
been seriously wounded and need urgent medical attention. I was among
those that were able to evacuate to our neighbouring countries and I=E2=80=
=99m
now in the refugee camp of Ter Apel Groningen in the Netherlands.

I need a foreign partner to enable me to transport my investment
capital and then relocate with my family, honestly i wish I will
discuss more and get along. I need a partner because my investment
capital is in my international account. I=E2=80=99m interested in buying
properties, houses, building real estates, my capital for investment
is ($30 Million USD) . The financial institutions in my country
Ukraine are all shot down due to the crisis of this war on Ukraine
soil by the Russian forces. Meanwhile, if there is any profitable
investment that you have so much experience in your country, then we
can join together as partners since I=E2=80=99m a foreigner.

I came across your e-mail contact through private search while in need
of your assistance and I decided to contact you directly to ask you if
you know any lucrative business investment in your country i can
invest my money since my country Ukraine security and economic
independent has lost to the greatest lower level, and our culture has
lost including our happiness has been taken away from us. Our country
has been on fire for more than a year now.

If you are capable of handling this business partnership, contact me
for more details, I will appreciate it if you can contact me
immediately. You may as well tell me a little more about yourself.
Contact me urgently to enable us to proceed with the business. I will
be waiting for your response. My sincere apologies for the
inconvenience.


Thank you!

Mr. Razumkov Mykhailo.
