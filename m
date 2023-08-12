Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A43577A12E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjHLQ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 12:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHLQ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 12:57:14 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8163A7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 09:57:17 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-447a3d97d77so1209128137.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691859437; x=1692464237;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hOIBS69+QHshImy2VskKWwD2lvTIAN8tj1nXE8AMFM=;
        b=aOwYw4KaZbK+LiQs87TBOIV4bpTLsfrK+S9kxzxmS175cOG880BL46i5O0WaHdvB7V
         GQlqmsLR/sXYnR1RMiPCHp2VmYASCq5xpueakDl4Idm4LJMSAcVLASOLFuG3BhAA/Uo0
         fiz799ntxYHG99wzCXJdPdYhCZq9VpYrhN/XD7yZ0YCNmARQwgvjSfjHxYSgIeNh3wJf
         Fa4IjTpg9RvVnRrHMGdHsfu6D6FKJ7r+kM/9J4lAhmucMGalMaN/lTEONt5SweUOsdUm
         7KIY0LmzM9Bb5S2LKntEvqBwpehFrdud7rxV+aTjWHBCS1+6ncoapR2xkbkxKLbAjTqp
         DhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691859437; x=1692464237;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hOIBS69+QHshImy2VskKWwD2lvTIAN8tj1nXE8AMFM=;
        b=LTOQHEdSwQxJDH2OuXmh3I2nDNJiEjq665LQ5K/rmsJgtFTsG5KZlvXZkwp+Z/rv3G
         +p8MHWWtvctR5+Qk48eJo2hgukqlA2k4TQLXEpVZ9eAsBR88rPa9ky7ckLrYY6nUPJgg
         GYwRtmEL7KosF4RJX7TQK/glTT7tR2cNJKv8dgVJmFTj9vYHQEi/EbownCZp1yM8S9XF
         bTJknAm16N5KZNCv+iKYSWj4nWcljprGzpjoIiJLY7R9d4XmMi6uJanHxIIeNt3lQiAR
         h8a5TGrgoDKWKPhFa6i9w/1ilqB9fqXAisYlEYVALiNahJw2s5jgoWzpsAfdA/v7rjSC
         bUFA==
X-Gm-Message-State: AOJu0Ywt3ERNdmO668bK5EfYaCafIgxS7umfJe2ZxtmPX97nA5wGqQXR
        7wskNHN+fnG07SAnMz1cOjxEPOBVvFFsZq0OpAY=
X-Google-Smtp-Source: AGHT+IEAzOPnHVyi8Vj1ONGxrutu9nWQWi6A614EYoK0KPbgw0e0Hkbw9O1dw4zN8xhnu8c0X85TfJKKseRasGwl7ek=
X-Received: by 2002:a05:6102:11f7:b0:445:209:cac7 with SMTP id
 e23-20020a05610211f700b004450209cac7mr3966354vsg.27.1691859436739; Sat, 12
 Aug 2023 09:57:16 -0700 (PDT)
MIME-Version: 1.0
Reply-To: esterwilliams5972@gmail.com
Sender: lindahuigea7@gmail.com
Received: by 2002:a59:c7c3:0:b0:3ea:6ddb:e51a with HTTP; Sat, 12 Aug 2023
 09:57:16 -0700 (PDT)
From:   "Ms. Ester Williams" <esterw863@gmail.com>
Date:   Sat, 12 Aug 2023 16:57:16 +0000
X-Google-Sender-Auth: 1pm3pdgq-s8bZiQIQXFnCtOaHNQ
Message-ID: <CAAjJ7WosnFPp=Xsu2xL50JZEG_tTOK2ng5G3=+x7q+RbvK4VeQ@mail.gmail.com>
Subject: REPLY URGENTLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2607:f8b0:4864:20:0:0:0:e2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [esterwilliams5972[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [esterw863[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [lindahuigea7[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May the Good Lord bless you as you read this message; I have come to
the decision to make a significant gift donation to you after careful
consideration to be used for a specific charitable project.

I decided to reach out to you because I have limited time on this
earth and prefer to have the money used for charitable causes rather
than allow my relatives to misuse it after my death. When I receive
your positive response,

I will provide more details about myself and how to get the funds
across to you. Forward your message of acceptance to:
esterwilliams5972@gmail.com

My best regards,

Ms. Ester Williams.
