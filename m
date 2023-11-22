Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645F07F3B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjKVBV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVBV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:21:57 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2944C91
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:21:54 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so5892900b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700616113; x=1701220913; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z21OQ2iFO3z7DQg6QknOOYzxcgh3HJwgSeTRYS8jyEI=;
        b=Td80l6b4iC8usdk+xPbqcsyPMZB0S0sjdK4wr2FXpZrJiyjSN/q7xB+ACLLuR2jPFA
         G0g2vGxV2iNy+ReiiWyPCl0sRp83m7655MGaCNWLk3WwFdLLolGm7V/XmvBHo/rS2qFM
         ThT0zpbrAKqvgxQdkMi9Yh/81lRxXNhQ55TiXCuFXc8PBkQ/EZrM8xVxBYxW5eqfCXna
         RFpO4vRPrWT+LD8/NDvr1FRW9G3tZcl34WcpBZufNMYBy1ugeuNy34wUhpUwQgLDrtLK
         crANWxiZkM2LaasrQvBQopM7z8M9Uc/M0tflP/Hk5AteSXTUQTw0vSJsmzEua/wm31A4
         TOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700616113; x=1701220913;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z21OQ2iFO3z7DQg6QknOOYzxcgh3HJwgSeTRYS8jyEI=;
        b=EM80njuvyccBs0IskjjBJvUpA7gh96RsTuVrdPft2J7gSCdW/AowgtV+ka2Sx9b0xg
         qD03LLQkqgwCQgXPXDs0Qx0wQu/V6KFD68ZMkeVtIoEJez5llaU3gRK9OWdt/91Pxc7u
         BjMeOIqdvrmVZEveywC1o1vBbUMOjfNHYQdLuzV2OPi9UL2JVk3syKgASDA9i/XlffpB
         jWjkXXV51yAkQuC+hPvZyZlfcL2Py7JVDmzlOC4zqdYoQgpnJbes82eNN0+TDCkX195e
         WAQaFmCyAHWdpQZNQ0GbDkzx8p1IeXen2YD+e9ga8fqwF513uPCjC5jsAg4S9THnKANi
         wRzw==
X-Gm-Message-State: AOJu0Yz6OwVnymh1TFeHIay6ILEzOYtCRv21/0fsJjiMh/09Pu8EhAj/
        7INz3m4sQ3GcS+l03v76r12VGoa5AYez+M237wEcHJz8
X-Google-Smtp-Source: AGHT+IGmPOfQvzKyRLcJ9KD34XHl/hPswqMjeZOzkV/tazyns0+8wnYkMu5FHEl1ITV2ukpwYOSthHLNCaQDLe3SSqI=
X-Received: by 2002:a05:6a20:be82:b0:186:a0d9:4189 with SMTP id
 gf2-20020a056a20be8200b00186a0d94189mr706799pzb.35.1700616113337; Tue, 21 Nov
 2023 17:21:53 -0800 (PST)
MIME-Version: 1.0
From:   Dwayne RIght <rightd942@gmail.com>
Date:   Tue, 21 Nov 2023 17:21:42 -0800
Message-ID: <CAAZfa0gY_NJH8A_sBQdEHG3bv6WpQjQddpo0gyP51ixG6Y9A8w@mail.gmail.com>
Subject: hey do you guy need this? pointer to cpu cache
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

basically i didnt check the source code but im working on it. planning
on adding stuff to the scheduler after some books

you can do

CACHEINT64 *x; // global

and slowly push data stuff into it through many functions

never really read an article that lets users use the cpu cache, the
cpu cache is supposed to be really fast, could work well on the new
intels and amd cpus
