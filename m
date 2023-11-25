Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD467F8EB8
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 21:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjKYUaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 15:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYUaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 15:30:13 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712EB10D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 12:30:20 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-db46725a531so1371795276.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 12:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700944219; x=1701549019; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sIb+DmjKgZoYhEC+SOMFqIkMc1Xw945g2E0k1oSYn7Q=;
        b=B3n8MKXzUZdNhTi7+GiJxfU0F1j33IZmDz48XKcHrp0c2IA1aXCIZPPHfQzmgsSDCF
         pRbbHQ2e6p8+3vqaABTOh/NxdlzgwFW5R4eSrKz5TgDDAJFYMBB3o15tiI3LsLRnVONI
         K2Ucyfk69Z0NJpaod3S+QlNKJ+Ls8wUG+0qh8YC88IE3VVA2qep12o8BOtf/y7Flc4mz
         QGgM8KfzbicGKBLXkZaUMy5IwwtTDy1zh4n0o2CzeKg2skMv6w83B6JdB8Q614/6HqNf
         rDyc05Lk6eic9AHNd/8vZ6RyXYGG4A+bTtBuwE50apaP0+xSbf42DRfQvKYa5wic5cOC
         6ukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700944219; x=1701549019;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIb+DmjKgZoYhEC+SOMFqIkMc1Xw945g2E0k1oSYn7Q=;
        b=H9CUnKTDFKTh/QyB8UqA7RYha/muiOo9HacAnOCVbY/htCiWPOXnbIL2hQl+eLPxd6
         +n7ReV8+Cuq/BLdADj02rLEnSMENVVpFz+cxEz4wFYLK0R1Rwd2DdOuX0IL8naC8YvhL
         5ilauM5xWm9gKCqpRqt87FViRGV71i2PkO0jIS25Jzf+zUCnTq3Art0ukVkDsACtmqgk
         9ZUxAQnpORVsLgqQqB2U71SVGIwM48hhAjj3Eldtu9oJIEiy3K0p5rptkRwtoPpMYfna
         m1EeFRRa0bX7sIgeivnXv2Wad58VlwM6UaeUhG1FYfYUXstz/JhYMKnkSI/prCSpawvr
         zG9w==
X-Gm-Message-State: AOJu0Yz/H0eZe8rHSUoAzboK7GxFaGELz/Ta0/q2MWI9uV5OLUa0+bt1
        69CLUfWUu5BVccj84oU1GzRE9FCeRB8Tu/zzvgvVFfng5NI=
X-Google-Smtp-Source: AGHT+IEOcEBIaCV4Katec3AopZcZPVf5k3NmPF381ANUHmwpugROV2BJPRBdWjLEA8GqfjZOno9TBYakJpwBj0rWwYk=
X-Received: by 2002:a25:814f:0:b0:d81:754a:7cb8 with SMTP id
 j15-20020a25814f000000b00d81754a7cb8mr5445991ybm.65.1700944219076; Sat, 25
 Nov 2023 12:30:19 -0800 (PST)
MIME-Version: 1.0
From:   Aaron Gray <aaronngray.lists@gmail.com>
Date:   Sat, 25 Nov 2023 20:30:01 +0000
Message-ID: <CANkmNDcCX+UwbEjy8Ly7jav9sA=Wark7xFEFdhX-KuR6uOkp-w@mail.gmail.com>
Subject: Can we please have a major fork of Linux into a modern and legacy
 versions ?
To:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hear Linux is going to drop a lot of legacy devices including the
ones dropped already. I am wondering if we can please have a major
fork of Linux into a modern and legacy versions ?

With a consolidation and security updates to the older version.

Kind Regards,

Aaron
-- 
Aaron Gray

Independent Open Source Software Engineer, Computer Language
Researcher, Information Theorist, and amateur computer scientist.
