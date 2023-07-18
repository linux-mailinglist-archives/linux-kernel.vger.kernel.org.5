Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF96E75775E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjGRJFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjGRJFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:05:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8408EFA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:05:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3143b72c5ffso5418586f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689671142; x=1692263142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6U0ivmK+OD2iLsWKjuPfkp86w61vJmhvBzlDEBqiXqo=;
        b=iTjdRvnCW3zSo3ABfPXoSk5JhJ+uAhzYg6YmwS3CBF7Zeo+hLD83sn5TY0Rt9WagAR
         +c7Jse96ejEz3Nt+LUcOtkqKm6JgzpaEd0qn05xbkqzUyGxbnMK4PBkBwvc5F5Ekqe+O
         NMTTjwobVLkE1A/oSdECk45WJeGVRLtqIpUZdgU+i5f6zPmdgz1psCqnjNxo41MU9vrf
         3f0I4YG6QnZXSzoz6sa69mb7TfT/uS5ULky4GGhplBwALPU2n1ozYfoKKNR+aCOxbLLt
         7O9iN2HVm4obbcVWF/FPq64MuNciur40C75FXTND1NapySXq5NgdHh/roebMZB6QpLsU
         bSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689671142; x=1692263142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6U0ivmK+OD2iLsWKjuPfkp86w61vJmhvBzlDEBqiXqo=;
        b=LpDrO820RAWSPKhJBadaUu9I321ufyWWFu1Av3wRP6p+736FwlcNqS1CTbrLZ75+ce
         +KBNKSh7XfoywHzN1naBtX7VVJu2qoBYtAl3b7HlI752Sb35MTtlN2aO+38Vb0AInPQD
         E8j6y77nZ9ZedswwWg8PDjrXQAekJX8Ehiwz6YgUqzcL8yB6u+qTdwCjBMmhDJl2vTKc
         fZHzq3PdUOUFePs0H+pc457zUrdPP9iTygXACKzpDrD9efSZ/DAX/NuZkiAeapcya1k4
         aiR0MJ1woj3fvB2WLpoDvS4HBUof95dFtGzLXQJ4jeLlOV2hZYtHy/Chqs9DXYgkOXag
         dfQA==
X-Gm-Message-State: ABy/qLZk5rk5n74Sg0yJcCu5x1zJBbL9mT90Fupf3+s3kEWnF++XDjd2
        TvO6Su+z6XfU9gAuVzpjc6Cy2l98TrGeZJTG6ig=
X-Google-Smtp-Source: APBJJlH/XrWosErrrxR5jaUVz6ZY6pm1rL4dn6K/7WEEOvRZzxpc2K8xKuvXdvLRv7EZClUYhlX6aQ==
X-Received: by 2002:adf:df84:0:b0:315:9993:1caa with SMTP id z4-20020adfdf84000000b0031599931caamr16112948wrl.12.1689671142048;
        Tue, 18 Jul 2023 02:05:42 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i2-20020adffc02000000b0030c4d8930b1sm1768918wrr.91.2023.07.18.02.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 02:05:39 -0700 (PDT)
Date:   Tue, 18 Jul 2023 12:05:36 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Sukrut Bellary <sukrut.bellary@linux.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Fix signed error return values
 handling
Message-ID: <b1ffe10d-e17a-4a91-8567-544a7aa96210@kadam.mountain>
References: <20230718085529.258899-1-sukrut.bellary@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718085529.258899-1-sukrut.bellary@linux.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:55:29AM -0700, Sukrut Bellary wrote:
> Handle signed error return values returned by simple_write_to_buffer().
> In case of an error, return the error code.
> 
> Fixes: 3c3d818a9317 ("firmware: arm_scmi: Add core raw transmission support")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

