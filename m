Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46017E3734
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjKGJIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjKGJI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:08:27 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A1A10D3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:08:17 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2c5194d4e98so58913071fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699348095; x=1699952895; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ScaI3rRuaXAIz9w9SrTMdz+ErKMb37xWHIASoSIhdi4=;
        b=oGoEgmPvf5aCel6WsPlusex5HmTSo1wYCcgsuacBjJQQLztbOsM7WcfhR8GF+YNsS0
         jY9DV0qHRj8F3VzW0aOE4j/Pj2VIKHFUUK5Sr1lZ+0WH6DDxiYW8gMBkU/ZrhgptmJ2a
         mjiOvpObpaWn9rq2zI86ZzhcUw+w3+JhPuN3UG+GshQsXTCP4j9sJV9GE4o1AjF2f3X2
         KxbXMOlLrKjOihC9l95kujzUnwSgm8v3pSTXL3JFNRpQzljM7efRB0pp9z8soeyfPnk6
         HJRwHpGY1Sl8bQOSrbQI2JcOXn9hMQZ8wIgPhXCZvH476R8c7iFYt/qCqmyoIzbCNfA5
         xv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348095; x=1699952895;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScaI3rRuaXAIz9w9SrTMdz+ErKMb37xWHIASoSIhdi4=;
        b=DypYXhQo+MuIDd3NTdb2fshIhZOuLJ44DwOxXr3RFcRZ+Xr9DvL4sMe0J5dvue2MQx
         HNhnXQTM9310kh9Qmwkt8RxUuiHHmvKBZkoczzQdqeLrCVdMxFY3kSktN9v1fxjjsGDS
         1HjPOB31TTQ9+D5mNGgvhoRBEJ0lt0nC4lm5i7Zj/4tygjlz2F/E/D8+XSsRGhu4Ar81
         BmHhNDwnMUQzbodo4sWwv9gQFE4Wz2y1bk8bq7ewIeJ6MkdyOF0vcmGDBmms6yCQ8Y0g
         qlBNSSPwLrHKqip/x6roz195Sbd87bAETxMbepDsiixRLiFhiQYH3MgpLeggPo7/45wg
         wcOA==
X-Gm-Message-State: AOJu0YzWxUl7werR+X9m12ZBK5En6jYAO7t1/yf+bB99Xo1+rYoIy4iC
        g2WEEg8L9Q+j6x/+O5PScfDsx04mQGMYiRU=
X-Google-Smtp-Source: AGHT+IEHYD5X9U01fDqlHMwdWCCRhoXFsVVdcoCFS8isMACh4y+lBWwLhVEix/Ok3qxUvvnxqCqyR2zNlxssL6o=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:9649:0:b0:2c0:cd4:c039 with SMTP id
 z9-20020a2e9649000000b002c00cd4c039mr310770ljh.9.1699348095659; Tue, 07 Nov
 2023 01:08:15 -0800 (PST)
Date:   Tue,  7 Nov 2023 09:08:13 +0000
In-Reply-To: <20231102185934.773885-9-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-9-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107090813.258015-1-aliceryhl@google.com>
Subject: Re: [PATCH 08/21] binder: keep vma addresses type as unsigned long
From:   Alice Ryhl <aliceryhl@google.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Llamas <cmllamas@google.com> writes:
> -	seq_printf(m, " size %zd:%zd data %pK\n",
> +	seq_printf(m, " size %zd:%zd data %lx\n",
>  		   buffer->data_size, buffer->offsets_size,
>  		   buffer->user_data);

This changes all of the print operations to use %lx instead of %pK,
which means that the addresses are no longer being hidden when using
kptr_restrict.

Since the pointers are all userspace pointers, it's not clear to me what
the consequences of this are. However, I'd like to confirm whether this
is an intentional change?

And if so, maybe it should use %px instead?

(Everything else in this change LGTM.)

Alice
