Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9128D79F256
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjIMTqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjIMTqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:46:16 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969E719A0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:46:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4e6so169898a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694634371; x=1695239171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dacT9sVMQZR6IpEeTHkxsBNkLKLIIgVKMRtbWHncpOU=;
        b=Ieng8YJzV1dYpW7tW3qMJfsk+eT10ASnUX5nKTV0I7pL9eY/TGvYkWmJITjUdAsLRc
         B/6+q1P3pmBLahskCYP7qZRCLEwLuzws6umXcViQMzgzG7a+76JQFG6prFrtOLhzJ+gg
         3J8XuXylqKbT60EuvfdPyKk/fARpqw4HH46d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694634371; x=1695239171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dacT9sVMQZR6IpEeTHkxsBNkLKLIIgVKMRtbWHncpOU=;
        b=l+BS/+sJYTe9XD//BJBO0ommdJdw6w9j/oxx8C28IoxyfR5A7gnJIjkoLSQRyuYZZT
         BoBph0mET8SMATbRlfmHKmCxnRjIoN/AYmOEbf2tBEVz21//kEmnkPjSBH27W3nHnVc5
         ltB7FOAZeOnnpELt2QmSuDQu5qRnzi/0PGQX70hdg1lIeBgx0pJReAptlgm+u3tjmAxh
         BklwQ4uR7Zb9QZwmhYNlulbpLb8qoZS5Ha3Nw3KdjQBvenlxEFUVCWFe8mXkQaMXqmaZ
         BMjXIWBHnstJRP4Do/XAY2imL/Bv1iImTra+MZTM25msAaTqNDEQoJa5ZN2OH1L96cTs
         lc1Q==
X-Gm-Message-State: AOJu0YyfluVVi25FqyRIE5sXP+wBiWqRO+XmaUwItWkkKQHdVeC7gi8J
        Ku/O3+/2n77xbF5uk23nS2k29QC8BUQsoTxDXMBEne78
X-Google-Smtp-Source: AGHT+IHzQloAO/nIqMvy0h6WRRikwyxVzpECFec6XJX12fXs2hsMxHT0flKOwEtYwkoIRd8BkHj5Ww==
X-Received: by 2002:a17:906:55:b0:9a1:fbfb:4d11 with SMTP id 21-20020a170906005500b009a1fbfb4d11mr3154427ejg.73.1694634370757;
        Wed, 13 Sep 2023 12:46:10 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id sb5-20020a170906edc500b0099bc0daf3d7sm8941598ejb.182.2023.09.13.12.46.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 12:46:09 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9aa2c6f0806so26801466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 12:46:09 -0700 (PDT)
X-Received: by 2002:a17:906:1099:b0:9a5:da6c:6551 with SMTP id
 u25-20020a170906109900b009a5da6c6551mr2636968eju.62.1694634369429; Wed, 13
 Sep 2023 12:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230912201102.1012306-1-jarkko@kernel.org> <CAHk-=wgLB9_z5TcvRKVsSk3BWPfkDeWN0pDMdEv=-hnrnTgX1Q@mail.gmail.com>
 <CVI1GKA044I2.2A5GRO80ABMNN@suppilovahvero>
In-Reply-To: <CVI1GKA044I2.2A5GRO80ABMNN@suppilovahvero>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Sep 2023 12:45:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiS2rHdPe9qQ4Ahzy6t6hbG18ihsOjBYxn3Nr88yen52A@mail.gmail.com>
Message-ID: <CAHk-=wiS2rHdPe9qQ4Ahzy6t6hbG18ihsOjBYxn3Nr88yen52A@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.6-rc2
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sept 2023 at 12:32, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> Ok, I'll make something more reasonable.

Well, I took the pull already, just saying "tpm fix".

I assume the only thing the typo actually causes is printk's with a
typo in it. Maybe some sysfs name will be wrong?

That's the kind of information I would have _liked_ to see in the
merge message, but I didn't then delve into just where the class names
might actually be used.

               Linus
