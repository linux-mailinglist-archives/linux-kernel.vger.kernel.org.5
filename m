Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D967784194
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbjHVNI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjHVNI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E55BD7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692709691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2i92USkhd3aYM8lBDCV9sQj/R5WX5KpFuC2KDLqm9uA=;
        b=huIQdUcLweLc6TCgSbuPRjiEJe/0GqGqxURwqK7pPAFgL4z8M1RWRDapoYb/8knlgebPsR
        wHY6aWRRZwXQX5CNmLgRigpDsVAZ1SJifpltunYwN2qdH3eAU7L8R9XeX2EoETX79Ahe2i
        /Baq/ItNCgz72n7XNsnCjVGsEZqzU7U=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-2Xmlm1l2MRu4atTYOFdArQ-1; Tue, 22 Aug 2023 09:08:09 -0400
X-MC-Unique: 2Xmlm1l2MRu4atTYOFdArQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a8607eae76so414030b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692709689; x=1693314489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i92USkhd3aYM8lBDCV9sQj/R5WX5KpFuC2KDLqm9uA=;
        b=dU+j77ViRxhqUg692HJf9g6iZzFTs4Wzz67bORegO2fJaj+nGAvze4WsmdoJr8ABWc
         b+fWYG7ZL/OMzaYaNC8yNQ7/R5zXoP9ZTQK0gEnggaqYrVPDJ/MaIOF7YmJZIrkZgxjP
         aUqXSFewcdFa9LxLTpXEaFtnPxmUlUPKJiDsyz7lYscwj/wh65h64UqoCsDLdfJcjvLq
         TfmW5X+dbiCjrcoyKSLqBEtEA27VJ2IE+h49wDNp5wxPRvijgvMHCL/OYD7hGI1DWxVn
         D2xvQbRm1FHfJywnhGeN5ERlvjNTSFXXMFLtxeO5nl8dyjCBUCCYXzXAdPzW9yhSit0g
         AKbQ==
X-Gm-Message-State: AOJu0YyZY+2VZt6DAN6R7WUD8WhD/Da0OxwiRSIfuoi5zJlyzAZXv96m
        Z+jkSVMp7ncXtjeyDhkqBBNWosz5G2O4OXIf+yQ7ud7gvnZbagPyQJ+NjzuDldMUrCpVNjV7YmA
        quYnf6lEMcA+EYvt0U27NwgKd5F9eL62StyvohkTT
X-Received: by 2002:a05:6358:c12a:b0:13a:cd06:f631 with SMTP id fh42-20020a056358c12a00b0013acd06f631mr6081336rwb.2.1692709688857;
        Tue, 22 Aug 2023 06:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5jnokBVqe6Vkt7S3b8TW/jdpbS9ktl8CZ+NlXNERyv6n6WFm96H+zxw3a8+CVtcXFhmkrn2bsT4tHJKpSLfY=
X-Received: by 2002:a05:6358:c12a:b0:13a:cd06:f631 with SMTP id
 fh42-20020a056358c12a00b0013acd06f631mr6081317rwb.2.1692709688582; Tue, 22
 Aug 2023 06:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230817075509.1438569-1-fengli@smartx.com>
In-Reply-To: <20230817075509.1438569-1-fengli@smartx.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Tue, 22 Aug 2023 21:07:56 +0800
Message-ID: <CAFj5m9+sm55FJAoM5iYtM=4y6VA7QwqD9bPqS7_uauwKqBvpNQ@mail.gmail.com>
Subject: Re: [PATCH] block: fix unexpected split in bio_discard_limit
To:     Li Feng <fengli@smartx.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, lifeng1519@gmail.com,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 3:42=E2=80=AFPM Li Feng <fengli@smartx.com> wrote:
>
> bio_discard_limit() enforces discard boundaries within the range of 32-bi=
t
> unsigned integers, resulting in unexpected discard cut boundaries.

Any bio size can't be bigger than UINT_MAX, see bio definition.

>
> For example, max discard size =3D 1MiB, discard_granularity =3D 512B, the=
n the
> discard lengths sent in the range [0,4G) are 1MiB, 1MiB... (1MiB-512).
> The next discard offset from 4G is [4G-512, 4G-512+1MiB).
> The discard of the 4G offset boundary does not comply with the optimal 1M=
iB
> size.

As mentioned, max bio size is 4GB, so there shouldn't be such issue.

Thanks,

