Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0EB80C1AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjLKHQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKHQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:16:04 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68E9D1;
        Sun, 10 Dec 2023 23:16:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D0F65C0066;
        Mon, 11 Dec 2023 02:16:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Dec 2023 02:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1702278966; x=1702365366; bh=Fa
        5YWtqIPyRrvJ5Lna2WJbE0LoWXH5vrU9UsWHQJ1Jk=; b=Kvtk2KeUGKAvxxLiDq
        0u0JLM+rR/QkQ6KEp+Xoyjsa0iv9cdypP8n9rEyeyMh54qibAM7dN0VS3r/s+Ho/
        sfQkUMlHlbMxoxDFHtHECyFmQR4nO9HPcqY5AZ2mwUpHYpYIEesQHGbfUlfQREWG
        eZ6IVXKZ02KZ7cpiPamGHu/wXOI5S3Jb/har917lTSa2uRxJPBVfAoQtNEGrPLil
        s4kjVxJUaimlM0mUa2nec4PD3PSJ8iPfa6raPj4StZm8OtmQExpJ69k8b3IQXBHV
        qn6i1ai2pi3e3JXq2tM1HJR7TDCE2/JnZEMm1/Br1KVSllo3Sses5vyP+Lp7JNFy
        AnpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1702278966; x=1702365366; bh=Fa5YWtqIPyRrv
        J5Lna2WJbE0LoWXH5vrU9UsWHQJ1Jk=; b=O/LlyZNn/ncucWDVbTTMlIW46r+Zy
        O2qaxMJzEOD40qD2Xdu0HJV5wu1aU4D876A+/yMahHT66G0kzMFXeY+yq4rNo1vX
        HVLKnU3VwLsQDf+TnrbS3CI0DWeNKvu0ROZ6VGMbChnSXIKz9nbfPfQhg0qE/MKZ
        OExGjYjNBtuieJmNW1drewff19jT9G3B98b62nPHzmzuez7qL68PKLIEt82O4/ss
        DRoBRLai7zc5aiwD5j/tVZuLhLxi0B89pwDcuV0oftQqsfmr1Db1ujt86GT+pQ6q
        WdKjA/zAV1FrfKL0cZ/T+tXdhMkOvHH84nymdRFsQ4WeB9BQZ+dHX194g==
X-ME-Sender: <xms:Nbd2Zc_JlZfM9ke6Nb_JGXR03UmgH8fi-kkcgI15bCffan0fYLhknw>
    <xme:Nbd2ZUsD4fIEsTgWxVUtfGSMMpneoozhyLfGkCBWwQPkeF_YOntuh8Uqbi0f4Gykl
    WHnWQoCOVZTmg>
X-ME-Received: <xmr:Nbd2ZSAhSJ1Cxn-DHfi3Gv4kA6bkFJdiCiKWMkww8dJMbsPLdtYwKnctTe0wmjSE-1xNCz05pRVEFPiHpIOn4KW5231HeAz7SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeluddguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:Nrd2ZcdG3FN2hcjBbeLqJcM-QkcFsmF2Uxavlor9-Bnf6YZ0_ClLEA>
    <xmx:Nrd2ZROxGKo78hf4ktjwqwvnTpHXi24D-Pyj3OuYKVnJA5ZhDGe5Hw>
    <xmx:Nrd2ZWkTBdQJyHjZ8XkG5d4Z3aCSmQxxJMMlcTpdXeDqa-eRInl2jg>
    <xmx:Nrd2ZdBA1WVvOHy-mH1_6nTBxBiydvvlNKXaTCGmQz0amCvue6pCFQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 02:16:05 -0500 (EST)
Date:   Mon, 11 Dec 2023 08:16:04 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the driver-core tree
Message-ID: <2023121114-gas-unstuffed-3045@gregkh>
References: <20231211152456.7526822b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211152456.7526822b@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 03:24:56PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the pm tree tree as different
> commits (but the same patches):
> 
>   3babbf614ae6 ("device property: fwnode_property_get_reference_args allows NULL args now")
>   1eaea4b3604e ("software node: Let args be NULL in software_node_get_reference_args")
>   bef52aa0f3de ("acpi: property: Let args be NULL in __acpi_node_get_property_reference")
> 
> These are commits
> 
>   a66cf024b377 ("device property: fwnode_property_get_reference_args() allows NULL args now")
>   b912c6530332 ("software node: Let args be NULL in software_node_get_reference_args")
>   cab48cbdfd27 ("ACPI: property: Let args be NULL in __acpi_node_get_property_reference()")
> 
> in the pm tree.

Thanks for letting us know, I think git can handle the merge here ok.

greg k-h
