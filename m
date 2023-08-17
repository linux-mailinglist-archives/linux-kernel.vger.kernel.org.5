Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310C177F96B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352144AbjHQOjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352085AbjHQOik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:38:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF08630DE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so10518756a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692283117; x=1692887917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9vWSNOyQ40/a//fJoXOBwGUU2y6drxoj4nh46dmg+4=;
        b=FowLE3Z7QscMh4BPSbKpcGzCmdve34ej608z/fV+mvkQe0bNMCU+VWjfdb0WrWvSKI
         DEyJ2UOInJBFQ46iFr4vVSfbjSSnQn92jYfjVHrDJzNmyB1w3DmiAEHaEipQ5vTQOzGG
         km6doR0hZ5SUOzhVDPp6wj9eJC+yWAxE8la9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692283117; x=1692887917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9vWSNOyQ40/a//fJoXOBwGUU2y6drxoj4nh46dmg+4=;
        b=TTPOQkxgWLyvaCi91ugxgMBGX0DUjpasOsJIh0psweocrOVQG/a9eM3HU5Pme93FGE
         oIxruDYEtCZaXHMyFFiHdeeUC4CuW9CRTzibJAgQvGL/XaWXivPxkyNJpjvANKqiFHF5
         50h58rgxq0XGt/4H/WAF8Fnbw9DL9MhAULsO6qkksQ01btm6sZhoSKGkdwVV+IoKr7+M
         Ls80WNvx/due0CVcKecODmgG6N5AJtX23zL/MffQm68YBguKwNtG0QcPcHZu8uCf19Q0
         h7XNxNewq/vm7jVSviO/XPKUp71RawQOJNv0egfGJUTpxg5w1INeZ95Y2MeapM2jF95O
         1YuA==
X-Gm-Message-State: AOJu0Yxv21NMXJxGTZSYVIZ/2H6tVx3mXtNUbFIvm049AZY6BXUJZUtD
        MUFknO2xCPSXsSZSb0SN6b3caNixUZzwctyNMSnum4bb
X-Google-Smtp-Source: AGHT+IEiIBcNezlCzECyYryd7Lnao3LXYuSTxnNofuitiQ54zz0aaK0GqsNnIqwvRg19WyU9I7SWEw==
X-Received: by 2002:a50:ec8b:0:b0:523:4996:a4f9 with SMTP id e11-20020a50ec8b000000b005234996a4f9mr5329982edr.34.1692283117240;
        Thu, 17 Aug 2023 07:38:37 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id l26-20020aa7c31a000000b005224d15d3dfsm9815160edq.87.2023.08.17.07.38.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 07:38:36 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so252905a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:38:36 -0700 (PDT)
X-Received: by 2002:a17:907:a067:b0:99c:570a:e23e with SMTP id
 ia7-20020a170907a06700b0099c570ae23emr5392064ejc.24.1692283115907; Thu, 17
 Aug 2023 07:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <03730b50cebb4a349ad8667373bb8127@AcuMS.aculab.com>
 <20230816120741.534415-1-dhowells@redhat.com> <20230816120741.534415-3-dhowells@redhat.com>
 <608853.1692190847@warthog.procyon.org.uk> <3dabec5643b24534a1c1c51894798047@AcuMS.aculab.com>
 <CAHk-=wjFrVp6srTBsMKV8LBjCEO0bRDYXm-KYrq7oRk0TGr6HA@mail.gmail.com>
 <665724.1692218114@warthog.procyon.org.uk> <CAHk-=wg8G7teERgR7ExNUjHj0yx3dNRopjefnN3zOWWvYADXCw@mail.gmail.com>
 <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com>
In-Reply-To: <d0232378a64a46659507e5c00d0c6599@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Aug 2023 16:38:18 +0200
X-Gmail-Original-Message-ID: <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com>
Message-ID: <CAHk-=wi4wNm-2OjjhFEqm21xTNTvksmb5N4794isjkp9+FzngA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
To:     David Laight <David.Laight@aculab.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 at 10:42, David Laight <David.Laight@aculab.com> wrote:
>
> Although I'm not sure the bit-fields really help.
> There are 8 bytes at the start of the structure, might as well
> use them :-)

Actually=C3=A7 I wrote the patch that way because it seems to improve code
generation.

The bitfields are generally all set together as just plain one-time
constants at initialization time, and gcc sees that it's a full byte
write. And the reason 'data_source' is not a bitfield is that it's not
a constant at iov_iter init time (it's an argument to all the init
functions), so having that one as a separate byte at init time is good
for code generation when you don't need to mask bits or anything like
that.

And once initialized, having things be dense and doing all the
compares with a bitwise 'and' instead of doing them as some value
compare again tends to generate good code.

Then being able to test multiple bits at the same time is just gravy
on top of that (ie that whole "remove user_backed, because it's easier
to just test the bit combination").

> OTOH the 'nofault' and 'copy_mc' flags could be put into much
> higher bits of a 32bit value.

Once you start doing that, you often get bigger constants in the code strea=
m.

I didn't do any *extensive* testing of the code generation, but the
stuff I looked at looked good.

               Linus
