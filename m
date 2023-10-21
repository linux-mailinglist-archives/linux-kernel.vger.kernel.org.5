Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41407D1C80
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJUKVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjJUKUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:20:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6668D1BF;
        Sat, 21 Oct 2023 03:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697883643; x=1698488443; i=deller@gmx.de;
        bh=dhDbWXH7BPN56bfie9iMzrJjndwh/b13GtRjH27O56o=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=IdAULbEV/M0lULP662Kp5mF9clSyt2OwYZDB04o1+7LkIoXDXBTxtezd+9209AIt
         3hGqVWhjBK4Vxcj+JiGzYHMuySCXjdlF3rAI/DhKAgHo/O54oGKhemQqDJ+U9DHz0
         0q5Sc5helbN4+W0HqdC82DoSN+Xt5Ly6fVKH63LiIL0PXPlTjc1u1h1pKcP7jSdun
         bMf9TEkCZlq/7SeACRifcngQ6NaFYh3/xJAIiJEBR0y3YT70uqUSOPp765L1m7Ar/
         ygp1qANXWSjUr6quCUfgiLOEYh3mzhBJrToaAgMbZZPNmncbQ1uWhH9EHymSoHFM4
         bT1YpDqH+Ll4GP9ZKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.149]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDhlf-1qlaF21o1f-00Apoa; Sat, 21
 Oct 2023 12:20:43 +0200
Message-ID: <46792c4f-5c72-4675-992d-e62ef5d1cc1f@gmx.de>
Date:   Sat, 21 Oct 2023 12:20:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/offb: Simplify offb_init_fb()
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <1c94c99117617c1a844f6551b7bca27f23c5f0c8.1697871190.git.christophe.jaillet@wanadoo.fr>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <1c94c99117617c1a844f6551b7bca27f23c5f0c8.1697871190.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z0RvpZoLIi5f72gOTfbcWj7KFnUCjNmRp1IzPMFdI5aQFRxKDDS
 Q8RL44q/pTzRNHx66vzmtyADeX/P0Onzi+2YOWFNzvpymgV1L1aZX5neDbGfDUL/ErP4QTh
 /eLDKJq//xCDULSBQoqpgYa481tJPmfVVrdbPeJDD32zluTZoq021xH9dJVe4OT2/LLzT2j
 S7dbZxiRaceWXYxiNysEQ==
UI-OutboundReport: notjunk:1;M01:P0:ejG3x8S8/g8=;j8Sebk2yOW0ye6bJh+BD/4sCR5u
 CLoAJjW6RpWT42D3lHuJT4nIh2SHJHulZaEaa6vwVF/Tkmf7fNAoRNtmJHFlfxA44Y+UtREoG
 Yngw3II+0a8cs72CYz8Vx8WmFuz38unGdE1daevGWKAgIVPZSMZOrKm//bJUeKopg/0h0g8eP
 cQvHBSKFyIZWeiSdrkTpDGWV96fx4Z7K9NcaxPxcn2zGtgqDfwzplnY9mS7xsKBlj9zbQ6fsj
 UMnQ9pQTO51+E0+dfPnco9u4+19Xxi/utCbgYx7jNbtdDFM6NNtdZCiNkkJY3DrdIUq1IrKeK
 9lWoboeyCBP2qvY+eoYgvSSFhunEoVtOgFp7E3n5uhXCPKH5TQvnAdLWGkKhAuqAcTzUSDhNj
 vmLUv9r0ieSoSGI8xcdOSCHM5ywz8vREsKvk1fdqUB4fHVqRaz5HA7gGEmj+1tzJfy2QdsYZy
 xE4hnH2CsGKDhbVTWtAWQBirK25G4GCwjSBLzbomhompxGnVw8cFyrr0IptjDCYGIe9D1PVi9
 XmAUCnizhfqX/os/wilfoWPeJeScRJAeK7cQ8zzQfyQXxdS7ztMWNFdQT8fQSoCZgaxiJVgFs
 1c6deoKc2YnhQzFQsQFnsO8ZQkht4/DFzwPThy5Xw627WAWJZLWrNyb4yG9OEi32+3tVZ84h6
 omOUipfxJhZi9mWnOjvvtDt9ZncAg+gZHL4wiX7Miu6vRzmTLjeYShDokq0hybF8ENPshS9AI
 I5Dp+bx7LOVFWFV4TuP8KlSNbik4fXFJSA5C0kmpYKawMsl4IhohuqS9hlGQ+z4QSxp5W3l4O
 LheUiI5xTNfoEjqyjQkn6rG69q4sbSPhgU4XExyWAHsh1oGCTHLcFGX3mTz0BnK4f60H1GlsQ
 jyLX4E+gwyQzxGcLn3RwNe0jEniWEwBqPs+ptu59DoplnjcOLR5Iy6XTjZOd1uoFAWycqUfns
 QHFePg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/23 08:53, Christophe JAILLET wrote:
> Turn a strcpy()+strncat()+'\0' into an equivalent snprintf().
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

applied.
Thanks!
Helge

