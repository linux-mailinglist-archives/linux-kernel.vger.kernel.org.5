Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2257544DB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGNWNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjGNWM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:12:57 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3D226A5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:12:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bb1baf55f5so6102305ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689372771; x=1691964771;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvhaGZOk6FnPl06sm3mW0Yfmju/nBEVwpPi4Wu+dVVs=;
        b=pTSTzlfNvhA1Iib7DPBz7FhjwL3BC1rL0QgQoiLxyWOz3+v34HAYUyH/DAKvMEtH6g
         P8QjtaJ+2ZpmRb34Td/CJF2Mq4LPVZ1yBIqubfz5Iphe0p9fd38L4wS7ywiPRBeugkaz
         o97w4vm6g8gLGPz4OaLuy2yfw1C1WuPPeYOuaXPDgKEqUgzd1e4kFwu6GlbtwMW/VJPD
         DFU0HndQTNCdud1zv4mnn7gxoyjAWjxOZBF/nwXNbfqZrO0Uk8Ly6Owz+Asw65gZMj7a
         Kk9j5J9lYek4zVUvTc7Gk5BteT+RrJ6E+m1lM0HCFPp/rKeKfv+kgT8+V39qKUXyW+O/
         UWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689372771; x=1691964771;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvhaGZOk6FnPl06sm3mW0Yfmju/nBEVwpPi4Wu+dVVs=;
        b=V9HRUptQm3Xet9bLs/982/H48H/qGxEZuaYXn6yvSc4vCLjbYXYhdrXjadP8ntMhBn
         OHxsA3HXM+msS1siYOC3Y3Q6SN7CLMthzkw4X3SVwKrglv+MbH7YvgbC7o3y4QwTcPT9
         2xNG8du91oEbDLtHISxzRKTiZOyCBFPbLXIqCnpg5Gys0MlGeQhswTAKiygL01IO+dCL
         AvEqJPXFFlQs5Hb6refqB/POXvGRkluc6q0jOlM9EWJ72a4JlKrdhTVzLesJijt4GHaD
         yu2f3WSi6x031tUGspzA+l1er2KXI2Q+UjOHFPyQeZk7gohKe9ISOaU8dJs/5pEsoYUs
         aBiw==
X-Gm-Message-State: ABy/qLZywhlG9V8Wo6siEAE5ZqjLyBnyHC9W9n5cHzvMejCXnsRHOv7+
        C+ylQtOjJ2+KD25b8frjzVkhU3phITr75tnvCeY=
X-Google-Smtp-Source: APBJJlFBANj+ZbnBSf/l9xO4UfU+FBKfZlVhi5qTU68H61Zb+kDj9gPERG5KcYMVcHVSB+KQ6AyeOuyMi6oASRwLGEU=
X-Received: by 2002:a17:902:7894:b0:1b7:ffb9:ea85 with SMTP id
 q20-20020a170902789400b001b7ffb9ea85mr5726747pll.29.1689372770740; Fri, 14
 Jul 2023 15:12:50 -0700 (PDT)
MIME-Version: 1.0
Sender: arunadogbee@gmail.com
Received: by 2002:a17:902:ce86:b0:1b0:1606:de79 with HTTP; Fri, 14 Jul 2023
 15:12:50 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Fri, 14 Jul 2023 15:12:50 -0700
X-Google-Sender-Auth: JDYwDrDf6ZB7pvxeb7Sr9K6mFaU
Message-ID: <CAGScg4rUC5Q4_2fhjfduid51DMzi4SQE2GN72=30h4cYvQSfrQ@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
