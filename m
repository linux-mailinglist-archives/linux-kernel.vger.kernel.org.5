Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E54753E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbjGNO5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbjGNO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:57:09 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F22359F;
        Fri, 14 Jul 2023 07:56:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b83969d625so13571811fa.1;
        Fri, 14 Jul 2023 07:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689346616; x=1691938616;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZEmcmnPKVyQByO618jb6eb3a7gSnqqcu00C8M1jvmA=;
        b=Dg1UJ8dYzY601p2JNpTJauqatYXYKV/p2+JqBL9TdFB4QKExv6C7QiHCdmMbbQJan0
         HYLWG6lOAt64JbMWhjp8Lb+XljPa4cPtm9UgWIz5KZ3wuBruM8eiYZYWndvKj2LV7TL5
         Vkoow1Rq/G8CzFCvBf7J8vrCDl3X1xQnj3rtKRYjXp+lj9+O5RlTFq22IrHbP01G2J+T
         g1fgfOeerqZj1NAopQuz674FsDcuhRsl+lkc1vThmyUMb8t3yJE4swCJOYkt/BB5w9mx
         FyvpqKk+TP2qhm34UlCWjUzFYk/u/QSOSG2t4kQME/mdiIYq7qNN5RnctF0EhefUIzkR
         DOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689346616; x=1691938616;
        h=in-reply-to:from:references:to:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ZEmcmnPKVyQByO618jb6eb3a7gSnqqcu00C8M1jvmA=;
        b=RmVhQs7/QYXKFiGvqNsclYNU4ZNi/IZwwhVk+5lBdz2lXaj3Kwy345bAs6PUd4SeSP
         aFDm8ITXjVUkubWOH3x/FvCtYpprfAL5cQjUGxshUXuJVvBAjC1LHzjVEQrhD7xAzc5R
         kjPBzYDfvNktD0g5gkS8DcT0432EBsWsrAyE5NvWdnw9Ait+8yJnEUkh/OT/WkKbGm0p
         nYAK3aaZZtno5J7mhk2e27g5VA+Gxl+1zkIOH/p3qOyDh92VDL5W/FQePaKJP1h8zJq8
         DSv3xAH6+nohJHfHDT7cWAyK+EKdvWOvDHRCT1lXnx/YDkCkJqjU59qqscevgJ0eb59S
         z8hw==
X-Gm-Message-State: ABy/qLYkT8JAxY13noyVbkz7D4i21144hpIERapanWeNIY7buWIX90P+
        xdkU3973Y3WWbNZX12/k20mbhy1/6jJT+g==
X-Google-Smtp-Source: APBJJlEf3KLRAD+1U56dLeqZJsyYvhjxdom7LDxUZFOUgLIIJm1m4YBnIjCqeBIAak0MFEiYeEx8Bw==
X-Received: by 2002:a2e:b0ef:0:b0:2b6:eceb:9b8 with SMTP id h15-20020a2eb0ef000000b002b6eceb09b8mr1208719ljl.10.1689346616181;
        Fri, 14 Jul 2023 07:56:56 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:6b00:a1a8:4887:1af4:637a? ([2a00:1370:8180:6b00:a1a8:4887:1af4:637a])
        by smtp.gmail.com with ESMTPSA id j5-20020a2eb705000000b002a7746800d0sm2025273ljo.130.2023.07.14.07.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 07:56:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------WS1iwDWS0LHmbVFGzfdOwRnK"
Message-ID: <9f0365cb-413f-2395-2219-748f77dd95a4@gmail.com>
Date:   Fri, 14 Jul 2023 17:56:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in af_alg_free_resources
Content-Language: en-US
To:     syzbot <syzbot+cba21d50095623218389@syzkaller.appspotmail.com>,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000bde775060071a8d7@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000bde775060071a8d7@google.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------WS1iwDWS0LHmbVFGzfdOwRnK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Syzbot,

Syzbot <syzbot+cba21d50095623218389@syzkaller.appspotmail.com> says:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14bac16aa80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1542573e31cfbec5
> dashboard link: https://syzkaller.appspot.com/bug?extid=cba21d50095623218389
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dd215aa80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14530318a80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4f212a7e36fe/disk-3f01e9fe.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/de6b12daf908/vmlinux-3f01e9fe.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2c1992ff2aaa/bzImage-3f01e9fe.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cba21d50095623218389@syzkaller.appspotmail.com

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master





With regards,
Pavel Skripkin
--------------WS1iwDWS0LHmbVFGzfdOwRnK
Content-Type: text/plain; charset=UTF-8; name="ph1"
Content-Disposition: attachment; filename="ph1"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2NyeXB0by9hZl9hbGcuYyBiL2NyeXB0by9hZl9hbGcuYwppbmRleCAw
NmIxNWI5ZjY2MWMuLjRlNGYyZDgzNzQ4MSAxMDA2NDQKLS0tIGEvY3J5cHRvL2FmX2FsZy5j
CisrKyBiL2NyeXB0by9hZl9hbGcuYwpAQCAtMTI0MSw2ICsxMjQxLDggQEAgaW50IGFmX2Fs
Z19nZXRfcnNnbChzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBtc2doZHIgKm1zZywgaW50IGZs
YWdzLAogCQkJCXJldHVybiAtRU5PTUVNOwogCQl9CiAKKwkJcnNnbC0+c2dsLm5lZWRfdW5w
aW4gPSAwOworCiAJCXJzZ2wtPnNnbC5zZ3Quc2dsID0gcnNnbC0+c2dsLnNnbDsKIAkJcnNn
bC0+c2dsLnNndC5uZW50cyA9IDA7CiAJCXJzZ2wtPnNnbC5zZ3Qub3JpZ19uZW50cyA9IDA7
Cg==

--------------WS1iwDWS0LHmbVFGzfdOwRnK--
