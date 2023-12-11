Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6183C80CAA4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjLKNSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:18:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B0CC3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702300689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYJjOHMQNv8CehdRtIn2st/ORKqIu2WjVhZP47qrPZM=;
        b=B5IWwCzCLI/z7PKtB5CPL0qghsp10IRRoJN3rXlP83l1hvauhJvnhVfeVV8/Rr3VoAXcI/
        ltMAN3upzOUq/5xIV+a8mTAwKJc2gtPJOZ8UBL5hoLJB0XxgnaKOxSv/xnbzFk7QUbHD9l
        zerWFiVOyeZk6adNwtYDG8GAzhQMsog=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-_WPeHaxlPkiMnU87_GJJ7Q-1; Mon, 11 Dec 2023 08:18:08 -0500
X-MC-Unique: _WPeHaxlPkiMnU87_GJJ7Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4257de8a5f4so59964501cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:18:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702300688; x=1702905488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYJjOHMQNv8CehdRtIn2st/ORKqIu2WjVhZP47qrPZM=;
        b=ssPbjBRij8KmqypGCypbeEHUb4mrUwcf3CiGfEWUqfzhlnSMP1Hu/xZYwKYFKVdLAC
         rbU74C5CLb2G00Ib7q9ufWpi4oUHdhpux6iR5bWntCfZLfLQVErWhqGMQuc3s08IH00N
         wLOy0EXQn5MBQeqr7LAftlJYMzAtA3lLlxJtvbT1e2vC4aR18JGpVSexLP1d3pInRo6o
         9MBkWZntxXUhfSMjovaNjUz060bCtbmv4Bsg0qg6/M7y+hVRZU32VUb1hjQ7I5IxyVFa
         r5KdtDETWzfp0YFPnGlQr+LRFoN57QmCNaNeC3OiNs+pEZDGjQO1qNgCYNnT6t/Ss2Jr
         Dvyw==
X-Gm-Message-State: AOJu0YyMO4etmbR7wqsUA74tRQJCydY9wQMKekkH2jqClEeAbtxxj5E0
        gWXdaNo107WDVMfdZR7suD9R0HymRwPmB24oaoddpuS+c5fdFnLTrjBbTsiCzkA8nGEoYNSWSLY
        9LmeZg6dwPPr50T6UQuym9c5viR4K1ipWh9dfnBOS
X-Received: by 2002:a05:622a:1b8b:b0:423:93d7:8078 with SMTP id bp11-20020a05622a1b8b00b0042393d78078mr5500883qtb.47.1702300687864;
        Mon, 11 Dec 2023 05:18:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3ApjHCSg4Tz7TvRn1/DLyTdxYh5Enge845CTRnBH5FlZN4+JNJt84O+SXzZjBgTLf7Tjmc8GE/aFg4o9HOMQ=
X-Received: by 2002:a05:622a:1b8b:b0:423:93d7:8078 with SMTP id
 bp11-20020a05622a1b8b00b0042393d78078mr5500872qtb.47.1702300687639; Mon, 11
 Dec 2023 05:18:07 -0800 (PST)
MIME-Version: 1.0
References: <20231208181802.88528-3-leobras@redhat.com> <CAK7LNAQk3Nm53qf95p7yQbSQ_M3phD_n5OMGxFWorGg_4fpQZg@mail.gmail.com>
 <ZXcLEKSBg9Bd1qEu@LeoBras>
In-Reply-To: <ZXcLEKSBg9Bd1qEu@LeoBras>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Mon, 11 Dec 2023 10:17:51 -0300
Message-ID: <CAJ6HWG5SfEC2=dzR8A5aGVeNFKwdsUa=BZm-iB4Rp4ZDKYAVMw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/1] scripts: Introduce a default git.orderFile
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 10:14=E2=80=AFAM <lsoaresp@redhat.com> wrote:
>
> From: Leonardo Bras <masahiroy@kernel.org>

Sorry about this, there seems to be a bug in my send-email script.
I will get it fixed.

[...]

