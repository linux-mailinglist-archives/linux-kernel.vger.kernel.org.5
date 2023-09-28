Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAAE7B1D22
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 14:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjI1M4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 08:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjI1M4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 08:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936C7198
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695905728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qI4XghGXIMa5N9aYtul1yzQ/Grglthn81P30tLktnuU=;
        b=VkW+23p3t+DLbC9yQBrpTX5iCnXkDrZ1VFT3pMNFsoz3G0r60qZwPjLjjemyTgVtCmST3T
        ElTW05x2aryT4BMswNOvKOybCyUtRxRJrNIuenZjSsqT32+8PnwCmHHzPE+mAFm2pV+4O1
        obb3VHYHE2cs/4arEbsWkPvlNbZl4sE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-kg_FSwKMOfyz643adDXB9A-1; Thu, 28 Sep 2023 08:55:27 -0400
X-MC-Unique: kg_FSwKMOfyz643adDXB9A-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-774382db0a5so1316515485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 05:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695905726; x=1696510526;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qI4XghGXIMa5N9aYtul1yzQ/Grglthn81P30tLktnuU=;
        b=aq2t2BDaOlDA0nQnVx43WF+xiDnk2w/rg5z3Qs8YtUv3pHnGUtG8UJA156gzYWxSMS
         aU8iejC3++m+Ej0CeryMZNss80V0ngVxBNY06ZamzqKIfb7dzvGzy4/A5VjbeVodfuCW
         LERbb0WiDdqDu26REeLAKjBrKu/GWN5Df/DLJAY3brqtkD55kq1aCL7KuBp3IVgNh+Xo
         5CYPKUPGtrhL40HuViYGNu6kx8L6xmVvcYef4F+nZpkjFALio0nzQWNOPWeNBXRVy/is
         oJpiHgxnWDymAuwzFxRFbnfy8/CGd30QnFV7sufLWdwzx4sPRI9urXuqsLBa38RfAgI0
         3ilQ==
X-Gm-Message-State: AOJu0YyYVX/aoTkNmIYo1lEcV70LkkrqcQnl2dBUnvDxsjl55EO1u4zF
        8JDWTKn28Nltd6Q6jgb7iFnh4QdqE4xlFx+XFtiDbWlHyFMkkV9y7hc28qPlhvtcBLqILLttiMj
        rKbGje2464PjWS6cjmoW++R9Lw4X4k52sjWc=
X-Received: by 2002:a05:620a:430e:b0:76c:c601:367f with SMTP id u14-20020a05620a430e00b0076cc601367fmr923537qko.36.1695905726452;
        Thu, 28 Sep 2023 05:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMXwEot4+7yhPCsisxUY3uf2TL6o8grOmBxp49L8okK6ad+7nPn/hioefoDjWOBvMUnPfWlQ==
X-Received: by 2002:a05:620a:430e:b0:76c:c601:367f with SMTP id u14-20020a05620a430e00b0076cc601367fmr923525qko.36.1695905726184;
        Thu, 28 Sep 2023 05:55:26 -0700 (PDT)
Received: from rh (p200300c93f19a200f43f623a676b2d27.dip0.t-ipconnect.de. [2003:c9:3f19:a200:f43f:623a:676b:2d27])
        by smtp.gmail.com with ESMTPSA id c1-20020ac84e01000000b00403ad6ec2e8sm3676249qtw.26.2023.09.28.05.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:55:25 -0700 (PDT)
Date:   Thu, 28 Sep 2023 14:55:22 +0200 (CEST)
From:   Sebastian Ott <sebott@redhat.com>
To:     Kees Cook <keescook@chromium.org>
cc:     Eric Biederman <ebiederm@xmission.com>,
        =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/4] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
In-Reply-To: <20230927033634.make.602-kees@kernel.org>
Message-ID: <6208fd50-43cd-85fc-e9a6-f10281a15902@redhat.com>
References: <20230927033634.make.602-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023, Kees Cook wrote:
> This is the continuation of the work Eric started for handling
> "p_memsz > p_filesz" in arbitrary segments (rather than just the last,
> BSS, segment). I've added the suggested changes:
>
> - drop unused "elf_bss" variable
> - report padzero() errors when PROT_WRITE is present
> - refactor load_elf_interp() to use elf_load()
>
> This passes my quick smoke tests, but I'm still trying to construct some
> more complete tests...

I've repeated all my tests with this one - no issues found.

Thanks,
Sebastian

