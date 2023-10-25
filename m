Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AD27D704B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344437AbjJYO7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343878AbjJYO7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:59:31 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80B4B0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:59:28 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-495d687b138so2208768e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698245967; x=1698850767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYQ3okT5d3Nr7vbYAmBVtOHd+MxXyv8cMuIfiU00t8Q=;
        b=ADGaA0xmleuK1l6FS4+GodnO0Qyh6/xhZt3WB0utPAcFv0AXCjKJAbuqZXj0PUE4WX
         8VN49wv5sVU/q8bI2A1e5H2XxuQHN6YmKcv1GIMoB593XxZH7Ji7z2nfZwTqrnwYQA1h
         hQ7kywC6XQ6VkAlItZXQ0sl1b7Q96tMVIhU7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698245967; x=1698850767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYQ3okT5d3Nr7vbYAmBVtOHd+MxXyv8cMuIfiU00t8Q=;
        b=wdVsUp7HPED4C0ahzNlBZzAd+5KUD4K5t/54Nu44lDI/meFI1qKoo5BnLumgd9BugW
         59OSwbA9Y3Khp9pJG+Ijwwba3LL/vcDU4Wc1x6Y6IL//TwjRQNF7oHbVlD1d2l17MLPR
         HLPu0J33vE0J1mQShDzKzWZ1jiMUIuW2+59eujAxILsdyg28E6HqQe4zTACDV0awTS9T
         pVoE3zRrwurAi517ebg9x9YkCNPMhVm/FwvF4+BigGtXITcyhpvt8CS6sJlLl1nUC+Y7
         XxmrkQVNo3qF4GPMjBmFZFWM7NPEVR2Qy3q55A75M2FaFE/CBKUu1wAgdTo0//nHw29x
         SAnA==
X-Gm-Message-State: AOJu0Yy4Gv2JUavzaDjPzrEhyGpIXh+TWLlADM78q9Y/XPgRPOQJxced
        5wd1lwgPYkDi0oxQu5BcrWAQsjrB37p30aDZD2E=
X-Google-Smtp-Source: AGHT+IGTjmSBB0wnk3+BWU75cqUx+evogXF5mZL02fGOC7IvqYB2uzGku8oP9jEKBrPGCogD7kPIVw==
X-Received: by 2002:a1f:f486:0:b0:493:7df9:bcc4 with SMTP id s128-20020a1ff486000000b004937df9bcc4mr10267864vkh.4.1698245967608;
        Wed, 25 Oct 2023 07:59:27 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id p11-20020a1f290b000000b0049aa4300a86sm1173vkp.39.2023.10.25.07.59.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 07:59:27 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-49d9ef118a5so2214920e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:59:27 -0700 (PDT)
X-Received: by 2002:a67:c190:0:b0:458:8ef9:a27d with SMTP id
 h16-20020a67c190000000b004588ef9a27dmr12269216vsj.20.1698245966786; Wed, 25
 Oct 2023 07:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231025143906.133218-1-zohar@linux.ibm.com>
In-Reply-To: <20231025143906.133218-1-zohar@linux.ibm.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 25 Oct 2023 08:59:13 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BSD2c4WwUTARx9OeqTjusgq7te8OzwdUi6Qk+L=9vSgA@mail.gmail.com>
Message-ID: <CAHQZ30BSD2c4WwUTARx9OeqTjusgq7te8OzwdUi6Qk+L=9vSgA@mail.gmail.com>
Subject: Re: [PATCH v3] ima: detect changes to the backing overlay file
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 8:39=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> +               if (!IS_I_VERSION(backing_inode) ||
> +                   backing_inode->i_sb->s_dev !=3D iint->real_dev ||
> +                   backing_inode->i_ino !=3D iint->real_ino ||
> +                   !inode_eq_iversion(backing_inode, iint->version)) {
> +                       iint->flags &=3D ~IMA_DONE_MASK;
> +                       iint->measured_pcrs =3D 0;
> +               }
> +       }
> +
Does this mean I need to mount ext4 with `-o iversion`? Or has it been
enabled by default?

I can test this patch out sometime this week and verify it fixes the
performance regression.

Thanks!
