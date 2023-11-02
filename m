Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5497DED2B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbjKBHVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBHVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:21:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F24A12A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:21:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c773ac9b15so83004866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698909688; x=1699514488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZzgMxS87UstitPyGkyQS3FJndMdCvFkV+kwkI7K4+Q=;
        b=SjZ0e5vmg3TSgHxdjsMOgzsXM3SzeuC5lwm9ZQxaWihpI7QkV5xQMKGQIEs7HegKhD
         Ef+nUj3jaoaYV4COVluB5Oei7uuY4Ab6+uBclYmQjFar+Q9aU+fTnEiYBg5OxlaX7sEe
         EWeQxRQ8MS2AEpHD4xwiGT4/3A1+/3HgsaioU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698909688; x=1699514488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZzgMxS87UstitPyGkyQS3FJndMdCvFkV+kwkI7K4+Q=;
        b=a0FeAnAi6LWBfAW6I1Bx//AvoySKHvD0KsRQOBnydfqh7lAajOAdHGp2K+Z9d483JM
         Wdlwf6+K/JVdKWC++E6896f32oyW4h/Jf2+U/wAQoDXJRRBYnH7VjROTP7mLioXxblQI
         g5GoXhRqme/hdVkHT7sEop6O6uP9M8jNbEDxiTJMWCUuJPj6qtEHJrxUoT/mWNikKO3r
         4MLJWWJbExkzHvI8oSlKOPzUPUOQkNBwPP+EnC3oTPjE1Rtza8nZOZqEnj1ZxMDfStSA
         HbdnFNWWYXpJxu8K2hKvDPaF21M/yQzpvpKGaqOQd4qJpwgpmYTNQqwCBkIaIFD1PXLN
         qgnA==
X-Gm-Message-State: AOJu0Yx4ilOq7p2C/bo1nJHUNDdWdUYhvG8jmW6lFQRblln+b9hoQJto
        +2336P7BUH50dMv4uYRIcWDgo0JavmMXP2iREZRIPmzm
X-Google-Smtp-Source: AGHT+IFg09qKIo40sbxW3h151jYn3NdYBWWvQdWcXzaKJPTMBexkvPmUkH0gAcq2o5CkSmSy3BmMbw==
X-Received: by 2002:a17:907:25c6:b0:9bd:f902:9a61 with SMTP id ae6-20020a17090725c600b009bdf9029a61mr3520965ejc.18.1698909688537;
        Thu, 02 Nov 2023 00:21:28 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090637cb00b009b65a834dd6sm769333ejc.215.2023.11.02.00.21.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 00:21:27 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9dbb3e0ff65so30593866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:21:27 -0700 (PDT)
X-Received: by 2002:a17:907:7ea4:b0:9be:8ead:54c7 with SMTP id
 qb36-20020a1709077ea400b009be8ead54c7mr3648207ejc.12.1698909686859; Thu, 02
 Nov 2023 00:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org> <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>
In-Reply-To: <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Nov 2023 21:21:09 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi=goCaTm6ZOKzm_ztky9ZT-vuGDWv39vVdtQT+oW=zEg@mail.gmail.com>
Message-ID: <CAHk-=wi=goCaTm6ZOKzm_ztky9ZT-vuGDWv39vVdtQT+oW=zEg@mail.gmail.com>
Subject: Re: [GIT PULL] Modules changes for v6.7-rc1
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, andrea.righi@canonical.com,
        keescook@chromium.org, zhumao001@208suo.com,
        yangtiezhu@loongson.cn, ojeda@kernel.org
Content-Type: multipart/mixed; boundary="000000000000642f940609263c74"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000642f940609263c74
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Nov 2023 at 21:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> kmalloc() isn't just about "use physically contiguous allocations".
> It's also more memory-efficient, and a *lot* faster than vmalloc(),
> which has to play VM tricks.

I've pulled this, but I think you should do something like the
attached (UNTESTED!) patch.

                Linus

--000000000000642f940609263c74
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_loguy4k40>
X-Attachment-Id: f_loguy4k40

IGtlcm5lbC9tb2R1bGUvZGVjb21wcmVzcy5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9rZXJuZWwvbW9k
dWxlL2RlY29tcHJlc3MuYyBiL2tlcm5lbC9tb2R1bGUvZGVjb21wcmVzcy5jCmluZGV4IDQxNTZk
NTliZTQ0MC4uNDc0ZTY4ZjBmMDYzIDEwMDY0NAotLS0gYS9rZXJuZWwvbW9kdWxlL2RlY29tcHJl
c3MuYworKysgYi9rZXJuZWwvbW9kdWxlL2RlY29tcHJlc3MuYwpAQCAtMTAwLDcgKzEwMCw3IEBA
IHN0YXRpYyBzc2l6ZV90IG1vZHVsZV9nemlwX2RlY29tcHJlc3Moc3RydWN0IGxvYWRfaW5mbyAq
aW5mbywKIAlzLm5leHRfaW4gPSBidWYgKyBnemlwX2hkcl9sZW47CiAJcy5hdmFpbF9pbiA9IHNp
emUgLSBnemlwX2hkcl9sZW47CiAKLQlzLndvcmtzcGFjZSA9IHZtYWxsb2MoemxpYl9pbmZsYXRl
X3dvcmtzcGFjZXNpemUoKSk7CisJcy53b3Jrc3BhY2UgPSBrdm1hbGxvYyh6bGliX2luZmxhdGVf
d29ya3NwYWNlc2l6ZSgpLCBHRlBfS0VSTkVMKTsKIAlpZiAoIXMud29ya3NwYWNlKQogCQlyZXR1
cm4gLUVOT01FTTsKIApAQCAtMTM4LDcgKzEzOCw3IEBAIHN0YXRpYyBzc2l6ZV90IG1vZHVsZV9n
emlwX2RlY29tcHJlc3Moc3RydWN0IGxvYWRfaW5mbyAqaW5mbywKIG91dF9pbmZsYXRlX2VuZDoK
IAl6bGliX2luZmxhdGVFbmQoJnMpOwogb3V0OgotCXZmcmVlKHMud29ya3NwYWNlKTsKKwlrdmZy
ZWUocy53b3Jrc3BhY2UpOwogCXJldHVybiByZXR2YWw7CiB9CiAjZWxpZiBkZWZpbmVkKENPTkZJ
R19NT0RVTEVfQ09NUFJFU1NfWFopCkBAIC0yNDEsNyArMjQxLDcgQEAgc3RhdGljIHNzaXplX3Qg
bW9kdWxlX3pzdGRfZGVjb21wcmVzcyhzdHJ1Y3QgbG9hZF9pbmZvICppbmZvLAogCX0KIAogCXdr
c3Bfc2l6ZSA9IHpzdGRfZHN0cmVhbV93b3Jrc3BhY2VfYm91bmQoaGVhZGVyLndpbmRvd1NpemUp
OwotCXdrc3AgPSB2bWFsbG9jKHdrc3Bfc2l6ZSk7CisJd2tzcCA9IGt2bWFsbG9jKHdrc3Bfc2l6
ZSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCF3a3NwKSB7CiAJCXJldHZhbCA9IC1FTk9NRU07CiAJCWdv
dG8gb3V0OwpAQCAtMjg0LDcgKzI4NCw3IEBAIHN0YXRpYyBzc2l6ZV90IG1vZHVsZV96c3RkX2Rl
Y29tcHJlc3Moc3RydWN0IGxvYWRfaW5mbyAqaW5mbywKIAlyZXR2YWwgPSBuZXdfc2l6ZTsKIAog
IG91dDoKLQl2ZnJlZSh3a3NwKTsKKwlrdmZyZWUod2tzcCk7CiAJcmV0dXJuIHJldHZhbDsKIH0K
ICNlbHNlCg==
--000000000000642f940609263c74--
