Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B188A807261
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378930AbjLFO2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378885AbjLFO16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8281BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701872884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQemMj12WIGjBZr47gXsOW9zpJs6p0UbQqP4YLY+F/c=;
        b=Sb5wmwJrIVsbGyBmrPFXfEQnybCEopCKw5xYhNS1VNNXvsk4JwlCkhSk2pItgG1bYaHtVJ
        RJ5MwBCGIqaGYE7mroFR0dpOlkaxoZHGlw4O/KWZI/Q1jzkLn7dciL/Mhwp2i7Kq/7PFmH
        O6o91OB2VUK7d75UWADRS9vYpONk5wE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-Qh3s0JyoNKGVzbN6jFlvew-1; Wed, 06 Dec 2023 09:28:02 -0500
X-MC-Unique: Qh3s0JyoNKGVzbN6jFlvew-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54cc6ae088bso213427a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 06:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701872881; x=1702477681;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQemMj12WIGjBZr47gXsOW9zpJs6p0UbQqP4YLY+F/c=;
        b=tTSREpp5pBFrtTa9S31HsQu4pBhrllACoFlaY2NnU5arOILEgufOA0Qp/Peo0dJUUq
         vgFPHvIGRlFxt2Gw8h2krezXKb3isHbl0AqYbzWJ0inEv+1/2WgBCe4vgxFWxFjfn3O0
         ZT1/eLbLi0OA0BeJwEVNnkscG8sZJvi2QRoFTEG2zo50QP37M47J/Yr3KlbVYiXH+ltl
         DKzAsEs7UI8USLW/dVBfrn24MRiIENYLYwWPHiE01JCsTT8ZFL1Hl+ztcpQDYSG2AFnQ
         Srgd5YadxooQpDuropCYg6fA2uDl53QENthCry98/jhxnYwHBpkDgTH+5mPzxvPqdTGZ
         /zDg==
X-Gm-Message-State: AOJu0YytK3YYf3MzdUU6vG6nhq28FJT19IW5E1I+TPXPJPOGGlMX7eIh
        RM9yyvN9IO4gifHiCK+A2V6ukA5SJa/djXJM7qfRAoQrWCslKVNA0LsHAaBqyn1l7WfZWgRsY/i
        +CgfC+WBFCL+FEuO9lz/yOkK0
X-Received: by 2002:a05:6402:51cc:b0:54c:672c:c361 with SMTP id r12-20020a05640251cc00b0054c672cc361mr1531612edd.4.1701872881145;
        Wed, 06 Dec 2023 06:28:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHugIYgkAQma+u3Rcpl7xfsrIA7QBzIlc/Fe/J91NHiDKxoNEHxJfIq2dPWK0/tYzv2Md7dIw==
X-Received: by 2002:a05:6402:51cc:b0:54c:672c:c361 with SMTP id r12-20020a05640251cc00b0054c672cc361mr1531597edd.4.1701872880773;
        Wed, 06 Dec 2023 06:28:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-243-102.dyn.eolo.it. [146.241.243.102])
        by smtp.gmail.com with ESMTPSA id k26-20020aa7c05a000000b0054c715008f5sm33117edo.6.2023.12.06.06.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 06:28:00 -0800 (PST)
Message-ID: <d94ba990b99c01853cdb190895185ef3b7834fb1.camel@redhat.com>
Subject: Re: [PATCH V3 net 1/2] net: hns: fix wrong head when modify the tx
 feature when sending packets
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jijie Shao <shaojijie@huawei.com>, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, wojciech.drewek@intel.com
Cc:     shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Dec 2023 15:27:58 +0100
In-Reply-To: <f7588e40-0fea-4350-89fe-c432eacb68f7@huawei.com>
References: <20231204143232.3221542-1-shaojijie@huawei.com>
         <20231204143232.3221542-2-shaojijie@huawei.com>
         <ffd7a4cbefa8c4f435db5bab0f5f7f2d4e2dad73.camel@redhat.com>
         <f7588e40-0fea-4350-89fe-c432eacb68f7@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-12-06 at 20:31 +0800, Jijie Shao wrote:
> on 2023/12/6 19:18, Paolo Abeni wrote:
> > +		priv->ops.fill_desc =3D fill_desc_v2;
> > +		priv->ops.maybe_stop_tx =3D hns_nic_maybe_stop_tx_v2;
> > Side note: since both 'fill_desc' and 'maybe_stop_tx' have constant
> > values, for net-next you should really consider replacing the function
> > pointers with direct-calls.
> >=20
> > You currently have at least 2 indirect calls per wire packet, which
> > hurt performances a lot in case security issues mitigations are in
> > place.
> >=20
> > Cheers,
> >=20
> > Paolo
>=20
> Thank you for your advice. Currently, because the hardware behavior is=
=20
> different, the two versions of ops are retained to unify the subsequent=
=20
> process. We will try to unify the two version ops, and if that does not=
=20
> work, we will consider maintaining the status quo. Thanks again! Jijie

Note that even if you will have to resort to call different functions
for different H/W revisions, from performance PoV you will be far
better off doing a test at runtime to call the corresponding helper.

Or you can use the indirect call wrappers - have a look into:

include/linux/indirect_call_wrapper.h

Cheers,

Paolo

