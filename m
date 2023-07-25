Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DE1761DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjGYP6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjGYP6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:58:34 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A36CBC;
        Tue, 25 Jul 2023 08:58:33 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso84008941fa.1;
        Tue, 25 Jul 2023 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690300712; x=1690905512;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KDPHVmrZzrWaxB7S22eSEgowz0/oT2a8WviPoFNE1Bs=;
        b=Vt0UW/4QXA8r+1Q75QsqTUSZBKefz0fG7HAOqNNwbgocQnJEA7MD9ASaGd7oBshNuN
         yCj4d3f0PFRaGjcRKxH3bpQJeZnt94cPJ7lh1YlfmejOHe4eNTEoBysxpw5JJR2fluyr
         zTGxXYCmWgXYCO5K5SjPolAOy7oRNOGkJIK5OiUj4/mnKFF/0P7DaohTNEh/Vd2n79iF
         GDzkLYY+c5m6k6PaI6OYK9PzmVgQhN8mF8I9BLwfpVzYZAF/ruGnghtJiWr5qHTRAinU
         c+ALgRQ/JSN6oeqGXZWBfWyXI2VTjm25tLWoNoe0lcsl+SedIq/4BX9+MNT2+WVgCXzS
         XZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690300712; x=1690905512;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDPHVmrZzrWaxB7S22eSEgowz0/oT2a8WviPoFNE1Bs=;
        b=VbXJidGUJoGEwWL/c/BSPTulw6v1ZgYrAr/E16iz9PQI7Hn0TGxuLYOTZ5TjK3P4+r
         2YRc7BjR6uvRBd8hRqTI26MCihGxNBG72fOSBoBeDokSeV44TytGsXovymKXqH2RonI6
         gIYsYe4AoSPJ/rGng0qhCzwWNj7gOxSO7aTc82rrm1YGXty6yNTr6fcDbvCeW6kbNUMT
         LA7bDlzyQfzp31uFzJ0lJRagAn5WR6PuIh3ovM35xVQPA8V8uGl35JpBBsqUocn0qxeo
         acBk7S1bQEGPw9ajGn0kbesIpTnSXwxMHsp+OOj+duvuCCOcjDMxQCz+oTRZmlYkfnBk
         BHVw==
X-Gm-Message-State: ABy/qLZenI/+WHmFfwIbQr2eXUUDTVbG0SSd0fPO9aM9QIAQsdL4WDSR
        hNp1HHSGKblBsV6dUjPhtxk=
X-Google-Smtp-Source: APBJJlHErb0hv3zP6dPtwLIEAfOCGmfbWI9JzmdQiVQQd1Mri6bGtnJO7G6Hs6TC2SrbPuI3QVWh0g==
X-Received: by 2002:a2e:8e85:0:b0:2b9:4413:864e with SMTP id z5-20020a2e8e85000000b002b94413864emr9655654ljk.53.1690300711655;
        Tue, 25 Jul 2023 08:58:31 -0700 (PDT)
Received: from akanner-r14. ([77.222.25.78])
        by smtp.gmail.com with ESMTPSA id x20-20020a2e7c14000000b002b47a15a2eesm3584084ljc.45.2023.07.25.08.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:58:31 -0700 (PDT)
Message-ID: <64bff127.2e0a0220.a28fb.62fc@mx.google.com>
X-Google-Original-Message-ID: <ZL/xIm8NS8mBOlWv@akanner-r14.>
Date:   Tue, 25 Jul 2023 18:58:26 +0300
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org,
        brouer@redhat.com, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] drivers: net: prevent tun_get_user() to exceed xdp
 size limits
References: <20230725153941.653-1-andrew.kanner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725153941.653-1-andrew.kanner@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please, drop it and see [PATCH v3] with the changelog.
git notes were dropped in v2 eventually, sorry.

-- 
Andrew Kanner
