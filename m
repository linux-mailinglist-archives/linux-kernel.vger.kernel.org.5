Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702C776DFB2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjHCFVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjHCFU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:20:27 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0FC3581;
        Wed,  2 Aug 2023 22:20:20 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3fbea147034so5777075e9.0;
        Wed, 02 Aug 2023 22:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691040019; x=1691644819;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FjvIn0GCh0YORFSjN+8K+tidTSJpF5JgufXyyK1skj4=;
        b=dV7IqfQemYjFOSPPRHARTTxnm/LaGIoOdaYEHjh4EcIy3zDtYHxHzk1VSNmaFHRXuu
         +8NkXxtGLE18tvQAMBQlHTCQLkxclxE7Cw2suHkHXDecsg1cdUDoURuy/PjwNypMj+yW
         3e9qPVFAyW8ZZkgExHsuUn75cj8A+dtkDMgiCsx284Qo4Pt/6UnRjpd/vy0g6XMD1Fuh
         Be/99ndhZzzIU7tX9sa3cGUx9eeD3eXdAj/4P9eL7qDwQKzIq8A0cg/w7DkoAo5t8XGn
         h1gEgqxHS0jzM396keB4KsznrxXMQ5psx5Qr4j7RBuHFlgo+3xBEHLrdWSZd71WWJcOi
         Wqxw==
X-Gm-Message-State: ABy/qLb2ZtnEXNA4aw+DDNkxH20J2e9vYjzQvvU93Cz2/pQHgDubqCFa
        yKASGn9+S3gXA8pgVlwtB2zmnmQ0gFRzQw==
X-Google-Smtp-Source: APBJJlEnGfQmTz/xujTcuuGFlIz/JG1xvth7Vuy8RnDZKfhwNr8L1JGvsjKDxfCwN+AUpyb2o7QTuQ==
X-Received: by 2002:a7b:c8ca:0:b0:3fb:d1c1:9b79 with SMTP id f10-20020a7bc8ca000000b003fbd1c19b79mr6315280wml.30.1691040018797;
        Wed, 02 Aug 2023 22:20:18 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4806000000b003143ac73fd0sm21041143wrq.1.2023.08.02.22.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 22:20:18 -0700 (PDT)
Message-ID: <30b83376-0b0e-067f-ed87-a68a3c45086b@kernel.org>
Date:   Thu, 3 Aug 2023 07:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-US
To:     oushixiong <oushixiong@kylinos.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230802022049.1674070-1-oushixiong@kylinos.cn>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v3] tty: vt: Remove some repetitive initialization
In-Reply-To: <20230802022049.1674070-1-oushixiong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 08. 23, 4:20, oushixiong wrote:
> Members vc_col, vc_rows and vc_size_row of the struct vc_data have been
> initialized in visual_init(), so it no longer to initialized them again
> in vc_init().

The patch looks correct to me. The duplicated code comes from some 1.x era.

The part after the comma should be something like:
"so it is no longer needed to initialize them in vc_init() again."

> Signed-off-by: oushixiong <oushixiong@kylinos.cn>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

