Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE1776F403
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjHCUX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjHCUXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:23:53 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E190F269E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:23:52 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-58653c9bed3so16586907b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 13:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691094232; x=1691699032;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=CTAdy697Oc40Dma38+0VyQ1aPUem55vYhZ8ZFreUl+Tknje5C9DeF91DePs7jz/In1
         7t2uN2Vk8ftbqpEVZWxll9QYZuVP6mocgaV4QpjXkFkvyRihaEuU5r8p56IJYw16V4JA
         gR7u300hOAwsB4wmtHI3SCU0OrjsqGCXE/HgzEmgZQeANZEKTB2k88D6THa99HMN1iAU
         AGge7bujWeohHVSxupJi/wdzyaOsyH4x6x7ewyPNPhs5y5S0ijyhAMJWlAEvKLa2LY2q
         cXgxFr8RJvTamlpqqQOl4bZJ8mjhZ0iIIzyQuaJ3FHZijXdf+y+C8aqGK4E4xIJxgj20
         cnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691094232; x=1691699032;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=ZcnCAXtAv3ol+odQJqgJnNvze/+WdjAqo8jVxKuQuko6oK2Ch6ETlkvwC1fsFKi8/F
         Dgj5fMhIA8KTWFiUBHEWR6HLTGxvCUQXQKB3hmt3ekgfv9PSa+hc/1fidOoOmSexo7PX
         gg1tScE/90D7O7PhlaW10R9m1b7xydJd28SodAPt2h4dNugzollardAXpNwj+RntG3BQ
         +JWzvHqtl+Kzh5XK30iBhBJzvXMMm/QfsxxTzx5Lo3uey3g9q2mwweL5ThcLDAITYX3b
         VtEwJb6GH0S2bQwN5hEe4pVJVguysbbJdTosWPFmcOZNCGkKS4KsNmWJhS7ocY1dLmkn
         XFsg==
X-Gm-Message-State: ABy/qLaSiSiYVgDj26Cmt4ZKvTpHDc0yiLM8f7g3cJk/blOKs2VFWM0D
        2xEc3cfaG5HFMZr9fWo06CUdTPQBWdYdTFJ06eo=
X-Google-Smtp-Source: APBJJlEc4l5fn1PfoG5lk5XKhmjaQqBEUOxdlJ/5iv5Br/LUmmbfO59MmE9PVsth+LqnZlqTz1Q5moWz7ezbdVshstU=
X-Received: by 2002:a0d:dd56:0:b0:583:6767:1cb9 with SMTP id
 g83-20020a0ddd56000000b0058367671cb9mr19095971ywe.39.1691094231889; Thu, 03
 Aug 2023 13:23:51 -0700 (PDT)
MIME-Version: 1.0
Sender: mrderick.smith2@gmail.com
Received: by 2002:a05:7108:158d:b0:311:eba4:1a86 with HTTP; Thu, 3 Aug 2023
 13:23:51 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Thu, 3 Aug 2023 13:23:51 -0700
X-Google-Sender-Auth: _kTshNqTrOxTBzzb6a55WoL6VEM
Message-ID: <CAO-9xd=bec+UqHrtD1qXd+cwCmyiozqjb_8yR4aGgxxQdPN=hw@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
