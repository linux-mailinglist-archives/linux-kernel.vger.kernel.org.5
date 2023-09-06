Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6FD793C28
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbjIFMDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237032AbjIFMDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:03:43 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B2010D0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:03:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52e297c7c39so4351096a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694001816; x=1694606616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG8v1WUrQJRuwyVst1yh78ZkZ2N3yjOTrkiIIhevQjM=;
        b=LsATkX3PA9RuR24Q+4eOh2Y8rccnXOWiVizTBz7KWfvxRSpcf594xfOHOupSDUkvUj
         u4h6921+rQoaYBkUgfWnt9C9+jWVAyVtwUwxb8+prT2fWtxmnUHfW33u7MtlarXAS85x
         ERmxFio49rs+7asTxMFyTH9IRvHM4e6zbvb+BikmtfkHXHUojktaSWv0cLk8HnfxMHs4
         9A16CfopSoi/YtNg/MAfWdu3WUhdXIHwFqpxja8h8/EbdiAEN67QNZPk4j0TrorvZXKQ
         LoOXE38Vc/Vnqc9O1t50ud9RUK1jqwJuQk/ugOHZ/EDU2OKhcGSl75UCVQbckd+NxsfQ
         jZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694001816; x=1694606616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG8v1WUrQJRuwyVst1yh78ZkZ2N3yjOTrkiIIhevQjM=;
        b=QLnQOdtsIqEbl0ryrrTaifi4hchZXMi9wy86leU3c4ppyRIJHZ1pTU8eL31pdn6Koa
         W5j14M8GHsdTugVd56VEHGOp/7xCvoQKRqzu6JsSOGIIgWvm9cXwCfy1BqxlxksIGmnk
         Jb494lAklHK3KkVgkSxH+ixkH/889PxzgwEwSaDHynHgiyyYuvCb9Pi//pIxpPdBpllm
         MBmoAJEWHeK5qyWv7LBUBr8MXs8Le4pp9/ehuj3eECpeVgHiqdIXMaH1xat+rnlJ5NMS
         86EZzZ8BwHPlz9++1+H6hbdMrjTLME8U86k6A1vt0Di+VaWA1Kra7xjxNUoHyg1VWfqL
         32QA==
X-Gm-Message-State: AOJu0Ywtg5WhpOHt05QR5wcMz9+/kaD4WbVzjVvbxVewEgZjrqICQh+c
        KumqLkAjrCZisr32PeW0yKr/F1gMMccT1o9lfTZsBQ==
X-Google-Smtp-Source: AGHT+IEq8qhz9cNHqr8duJ2KbTtO4ySOl5J8Jd6unVRxNtSyip3WQ7CbJufHcW0Xz4GUVvZWdnonI9xLeXNXTLjmBnY=
X-Received: by 2002:aa7:c0cf:0:b0:522:ca6b:ad7d with SMTP id
 j15-20020aa7c0cf000000b00522ca6bad7dmr2017626edp.9.1694001816458; Wed, 06 Sep
 2023 05:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230821152606.10325-1-vinayakph123@gmail.com>
In-Reply-To: <20230821152606.10325-1-vinayakph123@gmail.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 6 Sep 2023 17:33:25 +0530
Message-ID: <CAO_48GESs+C-jRTefgLbksRSS25HtAcpCmbGKgFDDee-UsPnVA@mail.gmail.com>
Subject: Re: [PATCH] Remove the parameter not described warning
To:     Vinayak Hegde <vinayakph123@gmail.com>
Cc:     gustavo@padovan.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vinayak,

On Mon, 21 Aug 2023 at 20:56, Vinayak Hegde <vinayakph123@gmail.com> wrote:
>
> Signed-off-by: Vinayak Hegde <vinayakph123@gmail.com>

Thank you for your patch. Could you please make the git commit message
a bit more descriptive? Please describe how did you find this warning,
atleast.

> ---
>  include/uapi/linux/sync_file.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_fil=
e.h
> index 7e42a5b7558b..ff0a931833e2 100644
> --- a/include/uapi/linux/sync_file.h
> +++ b/include/uapi/linux/sync_file.h
> @@ -56,7 +56,7 @@ struct sync_fence_info {
>   * @name:      name of fence
>   * @status:    status of fence. 1: signaled 0:active <0:error
>   * @flags:     sync_file_info flags
> - * @num_fences number of fences in the sync_file
> + * @num_fences:        number of fences in the sync_file
>   * @pad:       padding for 64-bit alignment, should always be zero
>   * @sync_fence_info: pointer to array of struct &sync_fence_info with al=
l
>   *              fences in the sync_file
> --
> 2.34.1
>

Best,
Sumit.

--=20
Thanks and regards,

Sumit Semwal (he / him)
Tech Lead - LCG, Vertical Technologies
Linaro.org =E2=94=82 Open source software for ARM SoCs
