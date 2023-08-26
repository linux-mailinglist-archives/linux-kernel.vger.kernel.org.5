Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE27899B8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 00:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjHZWYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 18:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjHZWYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 18:24:06 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9FB1BC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:24:04 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5734b893a11so1038172eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 15:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693088643; x=1693693443;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pTK2P+dSNpLdhHcbff7i9fxYGYQXK5wNucMBi2Hv5F0=;
        b=WiVYDkyXjmo68r8MWhq+C29UmOxeouMmYP/OJJeCxtbD7KgmGWQGDI5EqYgVCDqlPM
         xrBDoqvoj02bzDXTQypVM43frC2KeoN/CwgYmiPHEu8ZgR1dbAOIOBLTWVSiXILyBYDu
         SMQShMb6ZLpXFfQd12r+wquntSs/P/5QRUuztR4ymx1YVKNFmeIHitfYdV70PSZLTU3P
         MS1+Pcsr3iktEN4PDmwBrb38GNlhSIGywLh7buISSSQiu8stWhcffoRjK/AbNKC/MtSZ
         8qb8JKSZrGLS2Jh1awBhFTDbK8kKdTc6/GY6FV4B1VbNXXRH/ooA2EUiHCSMypOlubsJ
         Gjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693088643; x=1693693443;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTK2P+dSNpLdhHcbff7i9fxYGYQXK5wNucMBi2Hv5F0=;
        b=QFqOVKOiTiL44CJHDvPrxp1VSkVeDPKSF0ESJ6FqQ76vUUu7SlWEFxV3AuOfRgqhD7
         J1uTNuxf/5Mk7G7dcp/rC4mrgqxiQFiml3JJSsTcAMYVfOABFf4wm2PfVhh9jkide8D/
         KcWOCyYIQAQDxpIXUde4hKeOT/ka67CYpQqI+Em1aZewzNhbUqQgmN3HB3YeFRc2TFph
         C0EIzSK/8J2sU+X0VVCDzDkE6pplC0lFMshdiDa+fhqVjAix9tpHeZBTnnpOKUVQNgp+
         kTU7uDtMPyvvh79SB68dHcAS6uOovfAtRGCYbaAy1JFktSk0c2PCDZJgvzbURuXpS5tb
         mGfA==
X-Gm-Message-State: AOJu0YyKDfFSqZdejbOReJvb5SmNSNOvINMqAvK6FAPzTuMv6L8ePom2
        BcdR+RndbqOrb2yPmqg3FiEG8wXSYy9pa4U2aqQ=
X-Google-Smtp-Source: AGHT+IH3/4FqdEi+0VbRuiDiqN95qIVZ31Hm3GEWhygTBlrJbJETMRw2gI3Td9C2ioa8Xj9JLdpsKnF3LkWWXDj0UvE=
X-Received: by 2002:a05:6358:63a8:b0:139:cf80:1845 with SMTP id
 k40-20020a05635863a800b00139cf801845mr29488028rwh.12.1693088643260; Sat, 26
 Aug 2023 15:24:03 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrselizabethedward13@gmail.com
Sender: olamidevirgil@gmail.com
Received: by 2002:a05:7300:5798:b0:d9:922:9031 with HTTP; Sat, 26 Aug 2023
 15:24:02 -0700 (PDT)
From:   "Mrs. Elizabeth" <mrselizabethedward13@gmail.com>
Date:   Sat, 26 Aug 2023 15:24:02 -0700
X-Google-Sender-Auth: zWfgx6L3fuQgntQ62Ij6dZEDgIo
Message-ID: <CAM6Xz8J2m+RB54ud59KsuKk++aaoq50c2_c-V-RqT2x8X_WUoQ@mail.gmail.com>
Subject: Am Expecting Your Response
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FRAUD_8,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_BLOCKED,RISK_FREE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:c2a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrselizabethedward13[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [olamidevirgil[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.4 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 RISK_FREE No risk!
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Dear Friend,

I am Mrs. Elizabeth Edward, 63 years, from USA, I am childless and I
am suffering from a pro-long critical cancer, my doctors confirmed I
may not live beyond two months from now as my ill health has defile
all forms of medical treatment.

Please forgive me for stressing you with my predicaments and am sorry
to approach you through this media, it is because it serves the
fastest means of communication. I came across your E-mail from my
personal search and I decided to contact you believing you will be
honest to fulfill my final wish before I die.

Since my days are numbered, I=E2=80=99ve decided, willingly to fulfill my l=
ong
time promise to donate you the sum(=E2=82=AC9.5 Million Euros) I nherited f=
rom
my late husband Mr. Edward Herbart, foreign bank account over years. I
need a very honest person who can assist in transfer of this money to
his or her account and use the funds for charities work of God while
you use 50% for yourself. I want you to know there are no risks
involved; it is 100% hitch free & safe. If you will be interesting to
assist in getting this fund into your account for charity project to
fulfill my promise before I die please let me know immediately. I will
appreciate your utmost confidentiality as I wait for your reply.

Best Regards

Mrs. Elizabeth Edward.
