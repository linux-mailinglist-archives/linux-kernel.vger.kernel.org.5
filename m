Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBDC7621B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGYSlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGYSli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:41:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC0A19A1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:41:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-992b66e5affso973917966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690310495; x=1690915295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0I788wohjQE8SsbGgdpMx1YFIP2lgTgr+yd7Aw2Cjck=;
        b=b0pM0eFQWipjwvBA5rAEgQYT74RBhMdHIMtBF/Ievwknq0XgMDXN5xsJePKnz7vJNI
         rWPjk7fCOjEK52+9n3BtpCD0y9zCtP5LcUMruKr7o5/i77pHqJckQ8rbiUmKU/aOB4ir
         KhSAd3LCiSuGUyEDMSNTGxU3ky7ZrdH/yX9Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690310495; x=1690915295;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0I788wohjQE8SsbGgdpMx1YFIP2lgTgr+yd7Aw2Cjck=;
        b=bKpyIoauB29mxaU622itu1o99NNGzz9swvC4s9fTB7KPZwFMcCzM0Qy72v4X60DAnb
         i+VCer8BbryQ3iQJTxnX/l5sL8Z4MLZwdtcebCuKk+j2cU0EWayYNzi9XNRmugyDTO8U
         OdLBtmCMkqqgFBEhEKvq1ZTolZpNGHbDqJBGvlJ0pH6qUWSb4cHA5tNyKDdBV/pB0Tyd
         qPfP7yGawkzQOpZd7j29cV1y62QuK+Y/2BDIrzdWamKy6XHj1Ta2Am5p6iFM6iUdl5yZ
         Qs7PoXRLDcTIw1NXOJruWUnEQlCJNAIP125jEvsBA44HJ2jHvX1rDK0psyWoaJXigesU
         7YOg==
X-Gm-Message-State: ABy/qLasoLHoG99kwONdzfku3umWyT9q/en9KaUfbn6K8CyePMDVDcJc
        gHW3dXNBslbD5eeFLx8zbcBmrqXqzRny5Q9fsc946hlQ
X-Google-Smtp-Source: APBJJlH2lXeIBK7SWdbSFSuGp3F3D5Ril9Xj5Fw6UTrYA7ytZvvOcdThZrbDKHpQaKWiN6ZxsM42ig==
X-Received: by 2002:a17:906:8a5b:b0:987:6372:c31f with SMTP id gx27-20020a1709068a5b00b009876372c31fmr13432465ejc.37.1690310494822;
        Tue, 25 Jul 2023 11:41:34 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id hb12-20020a170906b88c00b00992e94bcfabsm8486641ejb.167.2023.07.25.11.41.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 11:41:34 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5222bc91838so3934575a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:41:34 -0700 (PDT)
X-Received: by 2002:aa7:d282:0:b0:522:29b2:e048 with SMTP id
 w2-20020aa7d282000000b0052229b2e048mr7180205edq.13.1690310493829; Tue, 25 Jul
 2023 11:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiu-dX+CGUnhsk3KfPbP1h-1kCmVoTV6FEETQmafGWdLQ@mail.gmail.com>
 <9adfd67b-4327-9233-8e87-3fd5f3f7280b@cybernetics.com>
In-Reply-To: <9adfd67b-4327-9233-8e87-3fd5f3f7280b@cybernetics.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jul 2023 11:41:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXgrO8dEYAQX6E8ffZXhzJ_+VPZyx1TcYpdRhQHD=L0A@mail.gmail.com>
Message-ID: <CAHk-=whXgrO8dEYAQX6E8ffZXhzJ_+VPZyx1TcYpdRhQHD=L0A@mail.gmail.com>
Subject: Re: SCSI: fix parsing of /proc/scsci/scsi file
To:     Tony Battersby <tonyb@cybernetics.com>
Cc:     Martin K Petersen <martin.petersen@oracle.com>,
        James Bottomley <jejb@linux.ibm.com>, Willy Tarreau <w@1wt.eu>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000008ba2fe0601541426"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008ba2fe0601541426
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jul 2023 at 11:27, Tony Battersby <tonyb@cybernetics.com> wrote:
>
> Something that I just thought of: the old parser could also skip over
> NUL characters used as separators within the buffer that aren't at the
> end of the buffer, as in: "host\0id\0channel\0lun".  If you want to
> continue to allow that unlikely usage, then my patch comparing p to the
> end pointer would work better.

Yeah, that would probably be better still. Ack on that.

That said, I just realized that *all* of this is completely
unnecessarily complicated. We allow up to a PAGE_SIZE, but you cannot
actually fill even *remotely* that much without using insane
zero-padding, and at that point you're not doing something useful,
you're trying to actively break something.

So the simple fix is to just limit the size of the buffer to slightly
less than PAGE_SIZE, and just pad more than one NUL character at the
end. Technically we're skipping four characters, and then we have the
last "real" NUL terminator, so 5 would be sufficient, but let's make
it easy for the compiler to just generate one single 64-bit store (or
two 32-bit ones) and clear 8 bytes.

IOW, we could do something *this* simple instead.

But I'm ok with your "track the end" version too.

             Linus

--0000000000008ba2fe0601541426
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lkin7m3i0>
X-Attachment-Id: f_lkin7m3i0

IGRyaXZlcnMvc2NzaS9zY3NpX3Byb2MuYyB8IDcgKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kv
c2NzaV9wcm9jLmMgYi9kcml2ZXJzL3Njc2kvc2NzaV9wcm9jLmMKaW5kZXggNGE2ZWIxNzQxYmUw
Li5kYTY2ZDkyNjAyMzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9zY3NpX3Byb2MuYworKysg
Yi9kcml2ZXJzL3Njc2kvc2NzaV9wcm9jLmMKQEAgLTQwOSw3ICs0MDksNyBAQCBzdGF0aWMgc3Np
emVfdCBwcm9jX3Njc2lfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2Vy
ICpidWYsCiAJY2hhciAqYnVmZmVyLCAqcDsKIAlpbnQgZXJyOwogCi0JaWYgKCFidWYgfHwgbGVu
Z3RoID4gUEFHRV9TSVpFKQorCWlmICghYnVmIHx8IGxlbmd0aCA+IFBBR0VfU0laRS04KQogCQly
ZXR1cm4gLUVJTlZBTDsKIAogCWJ1ZmZlciA9IChjaGFyICopX19nZXRfZnJlZV9wYWdlKEdGUF9L
RVJORUwpOwpAQCAtNDIxLDEwICs0MjEsNyBAQCBzdGF0aWMgc3NpemVfdCBwcm9jX3Njc2lfd3Jp
dGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2VyICpidWYsCiAJCWdvdG8gb3V0
OwogCiAJZXJyID0gLUVJTlZBTDsKLQlpZiAobGVuZ3RoIDwgUEFHRV9TSVpFKQotCQlidWZmZXJb
bGVuZ3RoXSA9ICdcMCc7Ci0JZWxzZSBpZiAoYnVmZmVyW1BBR0VfU0laRS0xXSkKLQkJZ290byBv
dXQ7CisJbWVtc2V0KGJ1ZmZlciArIGxlbmd0aCwgMCwgOCk7CiAKIAkvKgogCSAqIFVzYWdlOiBl
Y2hvICJzY3NpIGFkZC1zaW5nbGUtZGV2aWNlIDAgMSAyIDMiID4vcHJvYy9zY3NpL3Njc2kK
--0000000000008ba2fe0601541426--
