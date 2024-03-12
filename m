Return-Path: <linux-kernel+bounces-99761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFF0878CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9A51F21B75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27D66FC5;
	Tue, 12 Mar 2024 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU4tN9T4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728C5CB0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710209824; cv=none; b=BrVTvKDyINv4Jm9hGtzBBEEOj0K0FeGkgWoFMCFbWEBDz+rPhY/68Pw6Ls9NXR43RBQuNlWy3OM0U16ejjJY2oHm2DULP/yyJ178cZPJ4eOGhkOFJbMbz5UJ4o576DkhuueVoPqEaS8GmJ/+NXEjoWEQ12uwF2qmKjUt2RpxsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710209824; c=relaxed/simple;
	bh=nSh75CPRfKS/KL7VFhltqLjVu/hr3RGaBOR3B0hYW/s=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Gy/Ty1FOrtUjTL0UD3KUViFlEAlbCGXXXnCWBqdOuJ0ftL5wbfcEiC1ZHX0aMussdA1OZ7CRPaZPLn7TaRD+npjyq0733taTKKzThOs2R7kT7wN0OewbwMDyDz2y0xp7vVpYrnK9/qdf+/OfVKC7YdvjWZ80WIjacqAFTyBm9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU4tN9T4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8E2C433F1;
	Tue, 12 Mar 2024 02:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710209823;
	bh=nSh75CPRfKS/KL7VFhltqLjVu/hr3RGaBOR3B0hYW/s=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=jU4tN9T4xZemWRp+aXvoA/nmIstbNbyfBrRtZQV/X1XTyN3vR3RRMsl8Falb/Eapk
	 0tl7+cFfvtFDNt45YT7ClSm3uUMhKLjnVhRAKj5cDo8eYBkDOAeSBvU4lKodScXl4E
	 daz2W+DaV4Py7qRM+Lw29u3RHVLtSWGJAnYVO27oz/7WsdANyrtYznMz0n1WE+JB8j
	 RVj2AxuemkNpgYsHQ/0DtjjXzw17+hzz8WMq8gsWPYXj2Z5p2ZEa4x0WDV+FJS6PPs
	 Eq4iePJr/YunqK9MORid3S155idnkzu0XYgP4yDE4NWweXpvWtNYJ84FAHMErkGUvt
	 l+2oXSEZOIKkA==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id C05B5120006A;
	Mon, 11 Mar 2024 22:17:00 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 11 Mar 2024 22:17:00 -0400
X-ME-Sender: <xms:G7vvZXOTERjQ3P_x74F1HS8a2SIujGfX2VwQRJPG2cIC5FoCooRdoA>
    <xme:G7vvZR827_nGEg83ilS8ayfGh42qgRgdTnevXsUhaEopgSBr4STQoomy70A3TNs4k
    icyDe_iN3Kse5JN6fs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudevffdvgedvfefhgeejjeelgfdtffeukedugfekuddvtedvudei
    leeugfejgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:G7vvZWQ9bhPJE28rgwXyVk54e-t1wOaxAIJpObR2-jd0Qap2NSKITA>
    <xmx:G7vvZbtnK-YRSVYD2g3TuncGcuCsRYQN0Y2RVtx5JiHvcOQSCch2vg>
    <xmx:G7vvZffwVAbobDAT8C2lSwdUVWXlY5lG2JbjPHJqxODjcwGnM03ysQ>
    <xmx:G7vvZX0fQ9mPbCyvY7C372_GKwOVV4zERTMFz8otiAmq28wVpuSHgA>
    <xmx:HLvvZYcDJpgA38-Bo01kpwi1eRVVTwA9Y2m-rbEbNNlXkY-b91aGSWYncicFIm73>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 328E931A0065; Mon, 11 Mar 2024 22:16:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0645946c-f4f5-43b1-a9a0-03ed139036b3@app.fastmail.com>
In-Reply-To: <D4D747C5-2B0E-44B0-A550-BA05BE0AF2FA@zytor.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com>
 <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
 <bedfa55b-b1d0-4e59-8c94-dbc5f8485a7f@intel.com>
 <ef0419dd-9d7b-4b77-b63a-5f11aaefb570@app.fastmail.com>
 <08EFDEDB-7BBB-4D9C-B7E5-D7370EC609BE@gmail.com>
 <dd67a2b9-35ef-4cf8-b303-9e6b8692b390@intel.com>
 <D4D747C5-2B0E-44B0-A550-BA05BE0AF2FA@zytor.com>
Date: Mon, 11 Mar 2024 19:16:38 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, "Dave Hansen" <dave.hansen@intel.com>,
 "Nadav Amit" <nadav.amit@gmail.com>
Cc: "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>,
 "Christian Brauner" <brauner@kernel.org>, bristot@redhat.com,
 "Ben Segall" <bsegall@google.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, dianders@chromium.org,
 dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
 "hch@infradead.org" <hch@infradead.org>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, jpoimboe@kernel.org,
 "Joerg Roedel" <jroedel@suse.de>, juri.lelli@redhat.com,
 "Kent Overstreet" <kent.overstreet@linux.dev>, kinseyho@google.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 lstoakes@gmail.com, mgorman@suse.de, mic@digikod.net,
 michael.christie@oracle.com, "Ingo Molnar" <mingo@redhat.com>,
 mjguzik@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Petr Mladek" <pmladek@suse.com>,
 "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Suren Baghdasaryan" <surenb@google.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Uladzislau Rezki" <urezki@gmail.com>, vincent.guittot@linaro.org,
 vschneid@redhat.com
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024, at 6:25 PM, H. Peter Anvin wrote:
> On March 11, 2024 5:53:33 PM PDT, Dave Hansen <dave.hansen@intel.com> =
wrote:
>>On 3/11/24 16:56, Nadav Amit wrote:
>>> So you can look on the dirty-bit, which is not being set
>>> speculatively and save yourself one problem.
>>Define "set speculatively". :)
>>
>>> If software on one logical processor writes to a page while software
>>> on another logical processor concurrently clears the R/W flag in the
>>> paging-structure entry that maps the page, execution on some
>>> processors may result in the entry=E2=80=99s dirty flag being set (d=
ue to the
>>> write on the first logical processor) and the entry=E2=80=99s R/W fl=
ag being
>>> clear (due to the update to the entry on the second logical
>>> processor).
>>
>>In other words, you'll see both a fault *AND* the dirty bit.  The write
>>never retired and the dirty bit is set.
>>
>>Does that count as being set speculatively?
>>
>>That's just the behavior that the SDM explicitly admits to.
>
> Indeed; both the A and D bits are by design permissive; that is, the=20
> hardware can set them at any time.
>
> The only guarantees are:
>
> 1. The hardware will not set the A bit on a not present late, nor the =
D=20
> bit on a read only page.

Wait a sec.  What about setting the D bit on a not-present page?

I always assumed that the actual intended purpose of the D bit was for t=
hings like file mapping.  Imagine an alternate universe in which Linux u=
sed hardware dirty tracking instead of relying on do_wp_page, etc.

mmap(..., MAP_SHARED): PTE is created, read-write, clean

user program may or may not write to the page.

Now either munmap is called or the kernel needs to reclaim memory.  So t=
he kernel checks if the page is dirty and, if so, writes it back, and th=
en unmaps it.

Now some silly people invented SMP, so this needs an atomic operation:  =
xchg the PTE to all-zeros, see if the dirty bit is set, and, if itt's se=
t, write back the page.  Otherwise discard it.

Does this really not work on Intel CPU?

