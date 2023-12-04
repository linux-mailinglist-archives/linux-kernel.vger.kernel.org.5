Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635C18029B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 02:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjLDBKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 20:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjLDBKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 20:10:51 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE64E4;
        Sun,  3 Dec 2023 17:10:56 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c09d0b045so8376365e9.0;
        Sun, 03 Dec 2023 17:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701652255; x=1702257055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7z1N5dO8NDm/DCrI/ELJ3ueqyVV5fe5hp80A3mLNf8g=;
        b=aMXJTU0QiWF/bPyMD+TlBDmXNrrLtvJPJjmS65i0njPkKJ/5iZr4fV1YkLxqgHVYq7
         vugl8Rx2noow7iQiYiu14hpUQ0Uw+xS4XHHQkxgXoih/UjSMPT8RGNsLtVTmKUkccpHO
         NEqpns+MlJcwtbl70ETAosh3q6cTEwIJqc/u+qQdMVjYQn/jDyhP2x2lgVXeUjeMImYu
         rQiKCcX7mK0HTdGd499iy7M+BozSR/sG7wbqItXuVsrvpRRcF9AWltvoJ4p4DHTiJRYE
         bD+vRXOu2y0QBeEDf5B34qq1nYNliqnJbrdQEiwR9anG/yxkmWfNSO/8AgsndRurI/6v
         bixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701652255; x=1702257055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7z1N5dO8NDm/DCrI/ELJ3ueqyVV5fe5hp80A3mLNf8g=;
        b=wD5ZsT21f8iut+SI3ecSkxgF5/rJ7MoSAQhDw41EGWlWwK9l+zkb/sMAWymb0KEp7N
         Wq5qSAQTfpFnOL7+7FFvwzBttmXlmilu9/TYX/a9y5bdLJ7vyend7OqVNNIUFD4iLdnh
         yRS1pQ7pyUF+Nud57//IgM9TQmzAMTUzLaaFMgdFgoJtJPfwzlhfF39iYmAE63jVu5hl
         PjVjslGNLrD8J7xlxVpWW7ZgZQnmK2S4z2SBmJTxrCyGPnyPy/TSPGZp9OG1/bif1fne
         /TmskVV9X8XwbfW4dSabakrQswaqtMOaDxMmZxaOo63qmQI9/weLzgfOy41/XS44ynKF
         Qk+Q==
X-Gm-Message-State: AOJu0Ywjxz7RVj/V6vC1dwD8tPjiUMLhUd3pBfBHgV6VOy1tC68ljWzk
        1QaNmFd8Tc0LRyx6QhLQ6p1G/bvos7gR2blQxiojiI7XIo+CdQ==
X-Google-Smtp-Source: AGHT+IHbn6qn1Ma3CVdV3NIYkRzeuPMFp5sufb+8tQbZ6nBOrEWkpI/uAEFVTlCW1lU9CJ6dzRnY6SlSZAPvuSUjE/4=
X-Received: by 2002:a05:600c:2286:b0:40b:5e59:99e2 with SMTP id
 6-20020a05600c228600b0040b5e5999e2mr1408573wmf.258.1701652254691; Sun, 03 Dec
 2023 17:10:54 -0800 (PST)
MIME-Version: 1.0
References: <CACkBjsZGEUaRCHsmaX=h-efVogsRfK1FPxmkgb0Os_frnHiNdw@mail.gmail.com>
 <CABWLseuvzphU7+1BxXnjdbBMbqYzvXH-OSX+2bKi6KMNnFiqcA@mail.gmail.com>
In-Reply-To: <CABWLseuvzphU7+1BxXnjdbBMbqYzvXH-OSX+2bKi6KMNnFiqcA@mail.gmail.com>
From:   Andrei Matei <andreimatei1@gmail.com>
Date:   Sun, 3 Dec 2023 20:10:43 -0500
Message-ID: <CABWLsetF=xAnL3go91u-J=uyZ_jf-TFrOPzSHt00DvJrKixymw@mail.gmail.com>
Subject: Re: [Bug Report] bpf: zero access_size of stack causes array indix
 oob in check_stack_range_initialized()
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing in https://lore.kernel.org/bpf/20231204010139.2038464-1-andreimatei1@gmail.com/T/#u

Thanks again for the report, Hao!
