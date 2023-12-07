Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A4280872B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379089AbjLGL4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjLGL4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:56:46 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF1113D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:56:52 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id d9443c01a7336-1d075392ff6so6375565ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 03:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maxmobility-in.20230601.gappssmtp.com; s=20230601; t=1701950212; x=1702555012; darn=vger.kernel.org;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3OazQYOlByNpl6tBcxwU/o7A7vOOhp4cSha7GQ3HiU=;
        b=NKeuU6bymdYhboTn/TAYF1hSo6u/rQbupZgwAV8BYph2ZKKNyICwD1pn/qpjWitPCI
         WsbEaebyoAusGjM6+na4CIM5PR7H7cbdbcD6Ta+RugGGz4B7vOQotIufHlTmtujBvAiy
         Hfk5wAJ/Fu1ulK4IhJd9L40S9q+eHlJVf5cLmbILKGYBFoZjO37E3Khot3CjUxZjxoD9
         dn2qUXzsBNJ+os8ewgxp55EEY4t7bCOpvnBbY86JgI4tkN6nXWZYfAuQB7hHmtCmscgK
         QyOq47YVqlQ9iEK2uRQZYEVNJ+gcsA6pTL7gCITGYOQSHSbPO1tOe4GNwrs1pIwAwTi1
         /Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701950212; x=1702555012;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3OazQYOlByNpl6tBcxwU/o7A7vOOhp4cSha7GQ3HiU=;
        b=oHZDILgQ7Odw41c42LffduVGEfGKlIAzimZf2RuVZpQgUK/3SRWssljjAi681I7s/4
         Ld2vhrFXRsBv/6j5tdWKYB/NByFYs/iyAiQg5bJI1F0BLIsdqOHUy18oM+JhqxlpvZny
         6R3d/m0oeaHC1yEPGrHsNTUuNGrDlb0FBh6FFkbDDf2Tum5Tvlkpi7B7suXteOqEuEGy
         5hJ4xrAgsLxa5QD2xw/ZQ1/u7xzxFKAXR29SoFdJBqWxRgjckqXk9OUUYKwQNYk3m2rO
         ZWvVEZDHOJJN8DrdQXDfcNou1Y5I9TEAzlKMPaqJwvQzDTiKjVtt7tUxwluCA47MkrTC
         z3BQ==
X-Gm-Message-State: AOJu0Yx6quOSiWGxPidacrYH1oQW6bixlijZC2ZLHusJDQS2h7+dEQbI
        TH814FcwTOqvYYpsZYaOI+V8nQ==
X-Google-Smtp-Source: AGHT+IFewdismmf9TQZTxr0euiOcu1bJkHsiSzAjQZneREY/WSfu36/696+mYChxm0oz20xEqTz+/Q==
X-Received: by 2002:a17:903:258d:b0:1cf:6675:b313 with SMTP id jb13-20020a170903258d00b001cf6675b313mr2899735plb.22.1701950211770;
        Thu, 07 Dec 2023 03:56:51 -0800 (PST)
Received: from [192.168.18.23] ([86.107.104.227])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b001cfb971edfasm1200287plf.205.2023.12.07.03.56.42
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 07 Dec 2023 03:56:48 -0800 (PST)
Message-ID: <6571b300.170a0220.399dd.2351@mx.google.com>
From:   "Mr. Li Yong" <contactus@maxmobility.in>
X-Google-Original-From: "Mr. Li Yong" <liyong19511@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: A pleasant day to you,
To:     Recipients <liyong19511@gmail.com>
Date:   Thu, 07 Dec 2023 03:56:36 -0800
Reply-To: liyong000011@gmail.com
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        HK_NAME_MR_MRS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A pleasant day to you,

I am Li Yong, Executive Director and the Vice Chairman Board of Directors o=
f the China National Offshore Oil Corporation (CNOOC). I wish to meet a bus=
iness or project developer to discuss investment terms. Do let me know of p=
ossible opportunities in your region. I look forward to your response.

Best Regards,
Li Yong
Vice Chairman
CNOOC Limited.
