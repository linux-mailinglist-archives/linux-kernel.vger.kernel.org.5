Return-Path: <linux-kernel+bounces-24750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9282C1CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA191C23B86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73BC6E2AB;
	Fri, 12 Jan 2024 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pOJ1cgW3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2986DCF2;
	Fri, 12 Jan 2024 14:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4449BC433F1;
	Fri, 12 Jan 2024 14:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705069648;
	bh=rURI4j8Qzdu95xSW0tWCVC+7bpXBaT8ciPIXxAKQmg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOJ1cgW3CWiVAHKRwC/0P+QLn6Rc+YRjGcrFkax05Yw8qge//B1fNWXjwf40ZQNk5
	 HFGBx0FPiN/gLjP/Y5bNdy6nPnmigOrmQLGEEDTG3d4bEfrOy5KDDcfMa8wnnL9oNC
	 QC/SDSPB8RmizPkWwIIqQIgdsH/L6DyBaJeKO0do=
Date: Fri, 12 Jan 2024 09:27:27 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.7+ merge window
Message-ID: <20240112-steadfast-eager-porcupine-2c9b3a@lemur>
References: <c5ac3166f35bac3a618b126dabadaddc11c8512d.camel@HansenPartnership.com>
 <CAHk-=whKVgb27o3+jhSRzuZdpjWJiAvxeO8faMjHpb-asONE1g@mail.gmail.com>
 <CAHk-=wiHCkxrMCOL+rSGuPxUoX0_GSMLjgs9v5NJg6okxc1NLw@mail.gmail.com>
 <255e3328bd48c23fbaae0be6d927820d36e14404.camel@HansenPartnership.com>
 <CAHk-=wi6PenRqDCuumMK_5+_gU+JdUqrBEDS-XwFiaNdVRZAHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi6PenRqDCuumMK_5+_gU+JdUqrBEDS-XwFiaNdVRZAHA@mail.gmail.com>

On Thu, Jan 11, 2024 at 03:50:32PM -0800, Linus Torvalds wrote:
> > jejb@lingrow:~> gpg --list-key E76040DB76CA3D176708F9AAE742C94CEE98AC85
> > pub   rsa2048 2011-09-23 [SC] [expires: 2026-03-11]
> >       D5606E73C8B46271BEAD9ADF814AE47C214854D6
> > uid           [ultimate] James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> > uid           [ultimate] James Bottomley <jejb@linux.vnet.ibm.com>
> > uid           [ultimate] James Bottomley <jejb@kernel.org>
> > uid           [ultimate] [jpeg image of size 5254]
> > uid           [ultimate] James Bottomley <jejb@linux.ibm.com>
> > uid           [ultimate] James Bottomley <jejb@hansenpartnership.com>
> > sub   nistp256 2018-01-23 [S] [expires: 2024-01-16]
> > sub   nistp256 2018-01-23 [E] [expires: 2024-01-16]
> > sub   nistp256 2023-07-20 [A] [expires: 2024-01-16]
> 
> Look closer.
> 
> NOWHERE there does it mention E76040D.. Nowhere.

I'm piping up just because I know how to get the output you want, not because
I hold any opinions on GnuPG (I do, but they aren't relevant here). :)

Add the following to your ~/.gnupg/gpg.conf:

    keyid-format long

After that the output should look like this:

    $ gpg --list-key E76040DB76CA3D176708F9AAE742C94CEE98AC85
    pub   rsa2048/814AE47C214854D6 2011-09-23 [SC] [expires: 2026-03-11]
          D5606E73C8B46271BEAD9ADF814AE47C214854D6
    uid                 [  full  ] James Bottomley <James.Bottomley@HansenPartnership.com>
    uid                 [  full  ] James Bottomley <jejb@kernel.org>
    uid                 [  full  ] James Bottomley <jejb@linux.vnet.ibm.com>
    uid                 [  never ] [jpeg image of size 5254]
    uid                 [  full  ] James Bottomley <jejb@linux.ibm.com>
    sub   nistp256/E742C94CEE98AC85 2018-01-23 [S] [expires: 2024-01-16]
    sub   nistp256/3E01E40786F26FB8 2018-01-23 [E] [expires: 2024-01-16]
    sub   nistp256/920E9CA6AA3F170D 2023-07-20 [A] [expires: 2024-01-16]

Note, that keyids are truncated from the right, as opposed to git commits.

> And the above is actually being *generous* to gpg. The reality is even
> worse. Try this:
> 
>    gpg --list-key 37AAA9562C5CBD0C
> 
> and notice how it doesn't even list the subkey I asked about. Not even
> with '--with-subkey-fingerprint'.

Again, just because I happen to know the right incantation and it may come up
in a search for someone:

    $ gpg --list-options show-unusable-subkeys --list-key 37AAA9562C5CBD0C

You can add it to your .gnupg/gpg.conf as well:

    list-options show-unusable-subkeys

-K

