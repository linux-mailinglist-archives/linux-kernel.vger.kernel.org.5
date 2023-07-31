Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF54769974
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjGaO1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjGaO0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:26:40 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB9DB3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:26:39 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-113-23.bstnma.fios.verizon.net [173.48.113.23])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36VEQ1cn023734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 10:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690813563; bh=PTB+zTOglEGcpDuJkH1oIlACcE/4uJ8LKymuEGrBhyE=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=dLJycWW2cI9QngrH0N5NBkecfzJoxlN/oeSUmvHK0Dk5Z15pz8QMBbV1TqCUx8Ng4
         dO81MKpBvxKbfoYWZ/iugt+zhlo6nxE5ROapFTDQeqMVDmXJbaxk4nCNSzL2aarHMd
         idY5MGWh8vRYalsejIVNn+Q/uf6w78s3eizchral9RI+NI0aEAXEtpX1ZGgs4c/PZv
         kOJa+Eu05GEog3uSScBF23oqb8/TugKPqWIpJLXe/6eTO0srDiKtfwwVtgzZKglxdt
         Uk4kihyD+QxxEE6uEnkIbUbAV5gH3nvslIYbIxdXTxdK6SfrKClnjBe7xgBhdQN1do
         GBVr76cuKqv7Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3490715C04F1; Mon, 31 Jul 2023 10:26:01 -0400 (EDT)
Date:   Mon, 31 Jul 2023 10:26:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     tjcw@cantab.net, linux-kernel@vger.kernel.org
Subject: Re: vfat file system does not allow a space at the end of a
 directory name
Message-ID: <20230731142601.GA903325@mit.edu>
References: <CAC=wTOim6VZM7gKGQ8KuvbVSdmjyg=4G5sFbr+xY89ujPVOq8g@mail.gmail.com>
 <196f7191-5820-4480-99d3-e7ffc66e9c98@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <196f7191-5820-4480-99d3-e7ffc66e9c98@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 07:55:39AM +0200, Thomas Weißschuh wrote:
> On 2023-07-30 23:33:03+0100, Chris Ward wrote:
> > I had a zip file (from downloading pictures from Google Photos) where
> > some of the directory names had a space at the end. This unzipped fine
> > on an ext4 file system, but gave errors when unpacking onto a USB key
> > which had a FAT file system.
>
> AFAIK this is a limitation in the FAT filesystem itself.
> 
> The problem is that FAT stores filenames in fixed width fields.
> Unused space in these fields is filled with ' '.
> This means that storing "foo", "foo " or "foo ". would all result in the
> exact same result and it will be impossible to figure out the correct
> one afterwards.

Yeah, I'd argue that this is a misfeature in Google Photos; its
product manager should strongly consider stripping trailing spaces
from picture titles.

Disclosure: I work for Google but not anywhere near the Google Photos
product team, and this is my own opinion not Google's.  Feel free to
file product feedback in the Google Photos app, though.  :-)

						- Ted
