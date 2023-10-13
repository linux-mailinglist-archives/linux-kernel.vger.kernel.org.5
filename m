Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59457C808D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjJMIlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjJMIlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:41:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31245BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:41:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso280033166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697186502; x=1697791302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WobKMhut5Z1WRadmQFOCLE0LDQkau8vC9hdk6oaKD04=;
        b=wLKPJZ+Z0mK7aQNUswpmZW17heO2kVpBj7CPvHyxxex4pm1hCXdAF7+Mbe+gc/DZHP
         veaa4Z6E4gtp5QXKfHJhuHg2d4ZIt5rJ5qRA1ov6LFcZR/NiJAm/bB9cUhFmAeL4WJCs
         ZgHNzAH1RsS9+d+DXmYzbzvdXIZJPboQYrmWAa1A+yqRK4MN/pNTHZnxJSZ9q62PKym/
         nSyJIDUCVHXuhjoLJZJggECszyxfcQJsLZQjQp3ZsiD7t5+dpWjkq3nnGdlq1yNlTWiX
         7M/YxEGD7ojbHqfGSAzHk64+FZh3XZu0tia7flghXt9lSTE2QKEJ+MgozzzLsgHE0k1b
         OwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697186502; x=1697791302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WobKMhut5Z1WRadmQFOCLE0LDQkau8vC9hdk6oaKD04=;
        b=Zg43Oyj4D4q4uWDAZLFwEy9JNh8X2xjpckzSRfpSDasyQuT+Ip6TkloVyOpcovMt1N
         Qa83cW9FMXmx/gS9DRFEEggZDejthKtENqgS9YCBEGjLl/IuNQuR9xt1mpw64X7Fjx5a
         dH9QwR0BGvu9UwJZCQdmOnaHpdl0BNFcpKK+PatlQ4CiB+wX3WUW71R5OUc2iBoqrAAq
         AMATbBRi0UlMHJSKGIM0U/7yFqkok3VP8AavSm3iQ2I/qpFmZ4gxfzOVQzkNNWs+OrEe
         7Noij78xN6p1LDLrbSYmdTFoklrmeUsjYjqYsA3QcEY6cQAkuyPD9p9lvx8qqzk7wNg5
         +ONQ==
X-Gm-Message-State: AOJu0YzJZZvhzTtqi+IjnIKkKeFGfAaq66mfGZoSK5XStAQ8aXKVDjfP
        Otw/OyEAtFKrb8r+LYSQZefYjg==
X-Google-Smtp-Source: AGHT+IGl57G35Kgk+Wb+8j7IvEB83rBb+lMnwVBLThnUM4vWvaSEZOSoVzvBg81qjwsgjsDCv2K3XA==
X-Received: by 2002:a17:907:6d2a:b0:9bd:c592:e0ce with SMTP id sa42-20020a1709076d2a00b009bdc592e0cemr278581ejc.51.1697186502647;
        Fri, 13 Oct 2023 01:41:42 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o1-20020a05600c378100b00405391f485fsm1893848wmr.41.2023.10.13.01.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:41:42 -0700 (PDT)
Date:   Fri, 13 Oct 2023 11:41:39 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Archana <craechal@gmail.com>, Dan Carpenter <error27@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v3] staging: wlan-ng: remove strncpy() use in favor of
 strscpy()
Message-ID: <2c5720d1-616b-4cd2-adf9-58039b58e1c0@kadam.mountain>
References: <ZShI4amWv7sdqfse@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZShI4amWv7sdqfse@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Something went wrong in sending the patch.  It includes both v1 and v3
patches.

regards,
dan carpenter

