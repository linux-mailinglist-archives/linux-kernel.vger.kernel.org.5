Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2427F3320
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjKUQFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjKUQFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:05:37 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8401126
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:05:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-285196556fcso2000468a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700582733; x=1701187533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmJ5foKdCDZg8tIi4TPGeihCrXCC5qbN8sSmRpGmvoM=;
        b=b7S1gYGMZK/LETnoWv5ePvpD/zh0ypVnv8k3QLTiCCcV14ogz622x/1GQ5Xu5Fe69K
         HzfNm/s1VC4efzlVXXUw/N3SQsj5AVWr0fFmkfOvBdKzL0oUay9WtDKmSPcGIY9kcbZU
         30viN3TTgYrVYmz/rvrScU9oYzqEmCajkUilUgZ2YCxFXYpZxtwXPLqMa9tmWWwPq66z
         goENR6SrIlkbBnHJ2LQ8bPMKFJqJ2UfMWQo89eELdamx73Oo082oemVU7cRqtSJZyJ6W
         6iCiR32dD3W+5xFk3WVQcV26chquEuBcuJc+r7xUhpTclnUqUsyiPtuIpa+ZZzi7DKI+
         jG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582733; x=1701187533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmJ5foKdCDZg8tIi4TPGeihCrXCC5qbN8sSmRpGmvoM=;
        b=rNK+bfS6JBAHxBDWqui8X+wmCMXnpX9kPW7ri4tZdfdIez45PI48beUaBw7nRNxUDL
         XhFBCCeSJBw40ol71ZfQymDS7VXYhwRGSGuYMc+SjkxPL6AlCKfH4DsWCuETWBzKemEY
         8gXAhgR9WWSWWt3rlNJOt8bwGqDOfkHbuPqmp9ELmPdm3Le/zCe+eanGHKsVF4gbURHZ
         lwkD3h/2+oCJBqo8jMnL2hvq7DOQxRYCu96l+rI3YJL6bBHq+Lqy3ettQs4lYzApqVV7
         NfzljGQhYRUgIloLvewd111AI1il14655ZunEGf4QbiUbNMlA7UgkEp/ygc3pfgZUi4M
         sg2A==
X-Gm-Message-State: AOJu0YxndSb9Q+GUl2woz+M4ZuhXcXvkJxX9QAiBVZsOGkaaY8pfz28E
        LR+b8kSz4iDlIPTVaO7W9tht1+hLSnOl5Wv/LvY=
X-Google-Smtp-Source: AGHT+IGuQALslBqctoJ8yEzlNidGXCIbHB7HvO1+wbKEsxysx7DJQ6t93Ms9KX1AS83Umdf9IaOlzK+sSVY6I7jeYEY=
X-Received: by 2002:a17:90b:38c1:b0:27d:d9c2:6ee5 with SMTP id
 nn1-20020a17090b38c100b0027dd9c26ee5mr12266549pjb.9.1700582733189; Tue, 21
 Nov 2023 08:05:33 -0800 (PST)
MIME-Version: 1.0
References: <202311212204.c9c64d29-oliver.sang@intel.com> <VI1P193MB07520067C14EFDFECCC0B4C399BBA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB07520067C14EFDFECCC0B4C399BBA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 21 Nov 2023 17:05:22 +0100
Message-ID: <CA+fCnZfTJwfmO-OYcUst0fsWhRa+MzDtkv1N_bMob9_1BivdJA@mail.gmail.com>
Subject: Re: [PATCH] kasan: Improve free meta storage in Generic KASAN
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev@googlegroups.com, ryabinin.a.a@gmail.com,
        glider@google.com, vincenzo.frascino@arm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 5:03=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> This bug is caused by the fact that after improving the free meta
> storage, kasan_metadata_size() continues to calculate the metadata
> size according to the previous storage method.
>
> I will fix this in a separate patch.

Hi,

Please send a v2 with the fix folded in instead.

Thanks!
