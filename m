Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F0A7BEB62
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378562AbjJIUPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378542AbjJIUPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:15:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E23CAF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:15:36 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c88b46710bso23775395ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696882536; x=1697487336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KDFbaSwdbSiZRdRTlwqK2IxJqwEgX2EDTqDwpd1TSYQ=;
        b=St5eDxRCX6O+tz2OOkDeq4l0ftdhO5hCp8dYhPEIIUPkv6Zi9R828WiwUgKujVEXfS
         86SfoQUAo/tIXfHLWMc8pF5AAH4gmHMikDe/2qGSOHc1pVPmM9WiOH6br9C/kG5QpIOP
         ZR0/wHV/Ikp4iOs3IUbgW9jtNpyQQQGkJ8GBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696882536; x=1697487336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDFbaSwdbSiZRdRTlwqK2IxJqwEgX2EDTqDwpd1TSYQ=;
        b=Skjd9hKtpzyLH0S+GUF24iiC9SMFuxaRf5dWLwAHJzsU3RREp7Q7O403otcLdj9Lru
         uavNVGiuCmUUIF3cracPS6NNk6lBhlK7QQf3Xq3L8Wh5Gk9tMwDEtYDB7t5tMyKQCXEb
         KD8kMUIzdfSBr5/qdHA8WoBV2EmNDD17zpCmg+ExjY7wirNWzq8qV+YjfLDXhdmOsbFV
         0kNX6h/aeexh1fGnrfvVHp3UrEm7U5p69q8WubCuNr0zj2TmaBQPlEeVbw6na/XV6dM5
         npF2nPTpSmiAna8izDmoOs496rwEaNmCYxCu4zyg1mI3pTQgykGu6ERfDkY8xfGk7BqZ
         NPYA==
X-Gm-Message-State: AOJu0YxZqFrghPGZlOzInSVXwC4kXNjUzvaAIu0GLT1nTe6Q5+pxZi+G
        qO7jgvzVJTfqdTwe5rI5HG3mCg==
X-Google-Smtp-Source: AGHT+IHYYI/O+fK0SIGugLT8JGNaNBnCAefJgj5X+jc7ltNG/YWo68rvsHnAI1Y2XfQe6ujeIHx3gw==
X-Received: by 2002:a17:902:e847:b0:1bd:d92d:6b2 with SMTP id t7-20020a170902e84700b001bdd92d06b2mr16471450plg.10.1696882535935;
        Mon, 09 Oct 2023 13:15:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b19-20020a170902ed1300b001c737950e4dsm10038137pld.2.2023.10.09.13.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:15:34 -0700 (PDT)
Date:   Mon, 9 Oct 2023 13:15:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Chun-Yi Lee <jlee@suse.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        stable@vger.kernel.org, Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-bluetooth@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: mark bacmp() and bacpy() as __always_inline
Message-ID: <202310091310.F560494@keescook>
References: <20231009134826.1063869-1-arnd@kernel.org>
 <2abaad09-b6e0-4dd5-9796-939f20804865@app.fastmail.com>
 <202310090902.10ED782652@keescook>
 <73f552a4-4ff5-441a-a624-ddc34365742f@app.fastmail.com>
 <202310091246.ED5A2AFB21@keescook>
 <15f6b85f-b1ce-409a-a728-38a7223a7c6c@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f6b85f-b1ce-409a-a728-38a7223a7c6c@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 10:08:01PM +0200, Arnd Bergmann wrote:
> On Mon, Oct 9, 2023, at 21:48, Kees Cook wrote:
> > On Mon, Oct 09, 2023 at 08:23:08PM +0200, Arnd Bergmann wrote:
> >> On Mon, Oct 9, 2023, at 18:02, Kees Cook wrote:
> >> > On Mon, Oct 09, 2023 at 05:36:55PM +0200, Arnd Bergmann wrote:
> >> >> On Mon, Oct 9, 2023, at 15:48, Arnd Bergmann wrote:
> >> >> 
> >> >> Sorry, I have to retract this, something went wrong on my
> >> >> testing and I now see the same problem in some configs regardless
> >> >> of whether the patch is applied or not.
> >> >
> >> > Perhaps turn them into macros instead?
> >> 
> >> I just tried that and still see the problem even with the macro,
> >> so whatever gcc is doing must be a different issue. Maybe it
> >> has correctly found a codepath that triggers this?
> >> 
> >> If you are able to help debug the issue better,
> >> see these defconfigs for examples:
> >> 
> >> https://pastebin.com/raw/pC8Lnrn2
> >> https://pastebin.com/raw/yb965unC
> >
> > This seems like a GCC bug. It is complaining about &hdev->bdaddr for
> > some reason. This silences it:
> >
> > -	if (!bacmp(&hdev->bdaddr, &ev->bdaddr)) {
> > +	a = hdev->bdaddr;
> > +	if (!bacmp(&a, &ev->bdaddr)) {
> 
> Right, I see this addresses all instances. I tried another thing
> and this also seems to address them for me:
> 
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3273,7 +3273,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
>         /* Reject incoming connection from device with same BD ADDR against
>          * CVE-2020-26555
>          */
> -       if (!bacmp(&hdev->bdaddr, &ev->bdaddr)) {
> +       if (hdev && !bacmp(&hdev->bdaddr, &ev->bdaddr)) {
>                 bt_dev_dbg(hdev, "Reject connection with same BD_ADDR %pMR\n",
>                            &ev->bdaddr);
>                 hci_reject_conn(hdev, &ev->bdaddr);
> 
> and also this one does the trick:
> 
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -266,7 +266,7 @@ void bt_err_ratelimited(const char *fmt, ...);
>  #define BT_DBG(fmt, ...)       pr_debug(fmt "\n", ##__VA_ARGS__)
>  #endif
>  
> -#define bt_dev_name(hdev) ((hdev) ? (hdev)->name : "null")
> +#define bt_dev_name(hdev) ((hdev)->name)
>  
>  #define bt_dev_info(hdev, fmt, ...)                            \
>         BT_INFO("%s: " fmt, bt_dev_name(hdev), ##__VA_ARGS__)
> 
> So what is actually going on is that the bt_dev_dbg() introduces
> the idea that hdev might be NULL because of the check.

Oh thank you for finding that. Yeah, it looked to me like it thought
hdev was NULL, but I couldn't find where. :)

I think the best work-around here is your "hdev && " addition.

-- 
Kees Cook
