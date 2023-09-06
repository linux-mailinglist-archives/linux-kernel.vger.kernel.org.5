Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728D27932F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 02:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbjIFAnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 20:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjIFAnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:43:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE89E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 17:43:10 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68c0d886ea0so2573246b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 17:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693960990; x=1694565790; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+uJ1+KwQjMpdNiCngwvlv2FTzZnzkokoCYASnN36NE=;
        b=HwjFLDk0w+9EfytbQcc+NvYZtj1jYM1yGhjprLQclhGF8NJB78YXFMMEkofEKq6eul
         Q+2x4yk4LhBxatnpUefaVQDsjtigKbFFfJ44vGwhX/o93rlYFYh4FInxzWu9YTNOUdPX
         Ygtm8RS8y3Xl753AnCfosXd58gyLBKzv7hL2JdqAKaZOul2d64kw3RCBVVtjXF2qiOcH
         8bVtO0+fd3OxJHaPkfUk5UtpJm6Wq0X4966BsbnirC7AAfBoEYf9GRTvnD2j64sou/wz
         0Btmo4fnzEDsTadiyKYZidwR1CNRQeP2tW0BcgsXki6uS5NOa8qI8yqADQJgv5AhwOHd
         Ke5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693960990; x=1694565790;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+uJ1+KwQjMpdNiCngwvlv2FTzZnzkokoCYASnN36NE=;
        b=T2wL1/J/VjpAcvF/h6mj8lWduzUuRQYoywcXBlO2TcY4PKi+9DIg6JzNT5Gqa7Kuof
         p1aq8Xj43xt8xEAwdbknK0wH9cE6PbB6rlPiVtYZtgh82Rvb/wsQiLziJpnejK3M2/vk
         50mbcNjQcxwIvnzG5OvTsyyVCQnCW/Yg7OxTVeAEE3nx3JxwC5x4mxt/YwQJiNlH+PSD
         MQXjL1ggYWEtSmuE+HPRdWmINN1jTM30WteUTrTu6clbKYAF8huQOhWawm1u8zLiL5af
         RYBL18qItXk8qv7k4TMc3KFjjxgFHaPyJSTKHynXfRijmN5f06yVoavapef61Ew+EmNZ
         M5jw==
X-Gm-Message-State: AOJu0YwxddCXhM+3QHFMa2ssI2ZEgg3YxMYe/2zGvt3loXy1pXOotnVN
        D7lvslGh5Qr7QQyijt+aPQThcjjOQfFdxZtW0Mo=
X-Google-Smtp-Source: AGHT+IFezPmj/2YaeMZbNRFZMZG1zt/CLjvqkCvAp1JfustWzlMKbjo4GO9D6w4OSMmXeQgx55plPUsAMzqEDyauToQ=
X-Received: by 2002:a05:6a20:5499:b0:14d:16c:2d20 with SMTP id
 i25-20020a056a20549900b0014d016c2d20mr17904512pzk.44.1693960990329; Tue, 05
 Sep 2023 17:43:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a21:4986:b0:148:2f62:c480 with HTTP; Tue, 5 Sep 2023
 17:43:10 -0700 (PDT)
Reply-To: fionahill142@gmail.com
From:   Fiona Hill <lisa1985dennis@gmail.com>
Date:   Wed, 6 Sep 2023 00:43:10 +0000
Message-ID: <CAOd9DAo+3NUv9h7W3d=mWFGq_B_mkCWeGV2xGbdqz8ZKfUdKPQ@mail.gmail.com>
Subject: 
To:     fionahill142@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
