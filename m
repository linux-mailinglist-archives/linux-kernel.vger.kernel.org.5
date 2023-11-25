Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD8D7F8E06
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjKYTf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjKYTfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:35:25 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D324A3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:35:32 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so2786377b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700940932; x=1701545732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvpRpebtOuuuOLoBCqRcmSoaph+K+iYloqfsNNDdRyQ=;
        b=MrCbG7bgIiIHtReu1xVLsWFxssogIJPi/3pwRtixHhInyFmXQb/pG1mWjy5PJL28Zo
         SDjRqjE5kw06Rk23pnwqBcdDfTel41P+SUphySqr07d0btVqyaVrDyAdPXzwH75BJjV4
         t9VbLslLKfmNYMakVlAEGEXoQRBNRLRoKgrNpzvnvoIndkvPw+QFZ34bBoq20N8LvcKv
         wxd0z+lALcUwFZ9q4LaCu9eTpqT+9EHwBWwEBx5EJwf3PgKISqaRYQmI6RKNNyKK3gHj
         z3IJpu0CdlmPmukeLcDo7QdWKJvJTmnspqd6HN2bkUKF9u/dXpd37d2IVSv7XBBmDQZJ
         l79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700940932; x=1701545732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvpRpebtOuuuOLoBCqRcmSoaph+K+iYloqfsNNDdRyQ=;
        b=d4kXzfWo7nlxRGlvnW6L31x/r/OAczVnEpWr3L8qU0KqXlhSPI0Ri0+tkJJTTLQjsr
         sv0oEw8KsPifpbe37euzVEGus7/Sf6a2W4pROjLQEnOQnYOxGeKB0GqTzc3+DpXYj1Ec
         kd42DLOHLypmmeOicvPJYYbuhgCdgtvqQmjG/33c8p0WMLB+Ovs+mFin+5RU9sm5vQ0l
         cn9CaEdVsM3pxJ7g9DDXAa/CU1rqlLeRppnWbFbRc37n0KRPLftTWnovvyKiI+Mpq66A
         DHv+6qV54Hx6qhN3TQwoI3aN4W+mJRw8FnMWRX+4FIBabG1XOMSXe/RMEYtv4rVcgb0K
         fh4w==
X-Gm-Message-State: AOJu0Yy8R4sYL8bhQqeMAYFi/kAXTRvOafH8W3fScTgacvbXbyPkBJUl
        x7HCMYjTTWXZHVuVWRlmVlk=
X-Google-Smtp-Source: AGHT+IGOl0IMu9L1vIoOBpjEuozPEk/UGGwbIbzKGQ48jszuxinMjW8GYSxbsDLpu5JzXTPpmgri9g==
X-Received: by 2002:a05:6a00:8f0c:b0:6cc:298:eb30 with SMTP id ji12-20020a056a008f0c00b006cc0298eb30mr5011994pfb.29.1700940931799;
        Sat, 25 Nov 2023 11:35:31 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id p6-20020a056a0026c600b006c3402c5442sm4687663pfw.84.2023.11.25.11.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 11:35:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 25 Nov 2023 09:35:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Aditya Kali <adityakali@google.com>
Subject: Re: [RFC PATCH v2 1/1] kernfs: replace deprecated strlcpy() with
 strscpy()
Message-ID: <ZWJMhox_E0aBkYE6@mtj.duckdns.org>
References: <20231122212008.11790-1-mirsad.todorovac@alu.unizg.hr>
 <ZV5zQ0gRxzGwweYN@slm.duckdns.org>
 <4a01cd1d-c9c9-4946-add4-1acf6998a24a@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a01cd1d-c9c9-4946-add4-1acf6998a24a@alu.unizg.hr>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Nov 23, 2023 at 12:37:03AM +0100, Mirsad Todorovac wrote:
...
>  141 static int kernfs_path_from_node_locked(struct kernfs_node *kn_to,
>  142                                         struct kernfs_node *kn_from,
>  143                                         char *buf, size_t buflen)
...
>  172         /* Calculate how many bytes we need for the rest */
>  173         for (i = depth_to - 1; i >= 0; i--) {
>  174                 for (kn = kn_to, j = 0; j < i; j++)
>  175                         kn = kn->parent;
>  176                 len += strscpy(buf + len, "/",
>  177                                len < buflen ? buflen - len : 0);
>  178                 len += strscpy(buf + len, kn->name,
>  179                                len < buflen ? buflen - len : 0);
>  180         }
>  181
>  182         return len;
>  183 }
...
> This is safe, for we see that in case of count == 0 strscpy() just like
> strlcpy() turns to a virtual NOP.

The conversion itself isn't dangerous but it changes the return value of the
function. The comment is not updated and the callers are still assuming that
the function returns full length when the buffer is too short. e.g. Take a
look at cgroup_show_path(). All those paths seem safe but the code is more
more confusing because the conversions are half-way. I'm not necessarily
against the conversion but the benefit to risk / churn ratio doesn't seem
too attractive. If you wanna push this through, please make the conversion
complete including the comments and the callers and include a short summary
of the changes and why they're safe in the commit message.

Thanks.

-- 
tejun
