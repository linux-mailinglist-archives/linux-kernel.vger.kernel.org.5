Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C377A9A56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjIUSi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjIUSho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:37:44 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFEFD9D0B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:30:43 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bffd6c1460so20213801fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695321041; x=1695925841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=je3lP1GqCpTp1WJIazL9sCEzHC84Hlh5WUKnq4wtUQQ=;
        b=XlulifhbCFajWGBJyUp5ueWde0aAaVK4pzUc+F3lS+RxIJRU1GKc0zQCk/S5ClXjge
         3LukVAfwxTiAYsNBEaMaEX4bsMmOzlBhsKBzy/j5FSVqGTmsxd5SMBeoyZOkcNrXEgPy
         vj3CmKHfENTPmC4aAgI6GZm0gqd72MdWV8sf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321041; x=1695925841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=je3lP1GqCpTp1WJIazL9sCEzHC84Hlh5WUKnq4wtUQQ=;
        b=P0vCwSScpiAYkQvjC93qwvEYhv0NldwE3cMc1zVu+FKeGY2MNs0q5czX6ApmWLSAqC
         NolU2UzpOKq6FXfTWi2ym35+b6SYKQL9MlvKRA98bT86UKLZ5A86Vo5f7DlJOSDv7mh8
         3CxzgUQNMYMFmFV13FUQvOhBDMPQzQKv+EHFgT5QRZKskSGKjwRFwtKLx65tbt3vQIuv
         bwcnD/Wd/GBJm3tbfDjPJ6XDABGilOG+x7ybm0zKHvO8cSIAbwL4iecSoOEMrYGSsRcE
         7AX53DVLlqZx0MlQRNN4ToG3K5frB7WmDd3BFnMAGbO1EH8YTkDoZqzOvLZXHVTZAXia
         BhqQ==
X-Gm-Message-State: AOJu0Yx9ardiIt9Ih7+UoHT6H8/72kvKCPimejEhrmM3rQpDHpD4CyWE
        orohDtJm/4so90aBWi9MCW7/QxwVJwWMLJ398ty4KQSm
X-Google-Smtp-Source: AGHT+IEQyLRNDIB/PB1as2CR6uqo6PKaHNMkONpr49kZPERgQull/fF/H5UIZnNzw/QdjTHKfRyY+g==
X-Received: by 2002:a2e:910f:0:b0:2bf:ff17:811e with SMTP id m15-20020a2e910f000000b002bfff17811emr5319930ljg.14.1695321041216;
        Thu, 21 Sep 2023 11:30:41 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090619c900b009ae54eba5casm1412890ejd.102.2023.09.21.11.30.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 11:30:40 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-532aaba8747so1594846a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:30:40 -0700 (PDT)
X-Received: by 2002:aa7:d4d7:0:b0:525:691c:cd50 with SMTP id
 t23-20020aa7d4d7000000b00525691ccd50mr5853774edr.24.1695321040242; Thu, 21
 Sep 2023 11:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <a15822902e9e751b982a07621d180e3fa00353d4.camel@redhat.com>
In-Reply-To: <a15822902e9e751b982a07621d180e3fa00353d4.camel@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Sep 2023 11:30:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsTjLdt7RX-f-sFxqu_PieiBz=2OTjBF1CgW4j+OHfag@mail.gmail.com>
Message-ID: <CAHk-=whsTjLdt7RX-f-sFxqu_PieiBz=2OTjBF1CgW4j+OHfag@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for 6.6-rc3
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sept 2023 at 07:35, Paolo Abeni <pabeni@redhat.com> wrote:
>
> I'm wondering is if my PR reached somehow your inbox and/or if I have
> to re-send it.

I got it fine, and just merged it (still going through the build test etc)

                Linus
