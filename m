Return-Path: <linux-kernel+bounces-99670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28C1878B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10A8B1C2109D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F955A4E0;
	Mon, 11 Mar 2024 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5ceodxM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B856C5A4C6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200512; cv=none; b=nAhl0XQVsGbLE+B5k3n/Wb4QSpAvNEYIs5jh69T/5Ab9yH7DxyhRSERmMF+sJYPdDKGLPShTxY75boxFf1cp35KX5bDVRVkpCimGcUOmpsHZlfh7IX4dTt9KPGJLkHd1UDk28kfFCn9WPS4rcWzbdNi9Hd1xtgE1bhn8sVICatU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200512; c=relaxed/simple;
	bh=jjeKu/Fq+iDGPMTBTzqSsDgUhOYnfDFIBWLtDwFFWVc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=oFrRdabZ1Kpx+EBw7RGh0Bi/lLsZe0yM3VM+w0MTt4ZtEwh83JUwjUktkz+JCBr/m+1lLBrlpzOOxUfr78IlZvpRkvsS1i0mpZ6H5QkIN87TYIaiJG+1U24Qsffw3MROaaxzRw3kfs6ikZD2pf2eXIOboMgK96a5tfz3YEB6Qwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5ceodxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8747C43390;
	Mon, 11 Mar 2024 23:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710200512;
	bh=jjeKu/Fq+iDGPMTBTzqSsDgUhOYnfDFIBWLtDwFFWVc=;
	h=In-Reply-To:References:Date:From:To:Subject:From;
	b=L5ceodxMdFbJFXBShdbQkvUMn/xDml0vkeA8PIYiut/kgG5lKmnFORrqExlCq3iLX
	 e0SnljJlSCIWfoRxLawkKz3zlKR1lcXGKkC43pSlHZ/b9QU/lgc+RkWp3gX3CK/Tth
	 MEpV00gjknFVBvdvQ+0w35rpnuc42fDJnkGzeNxP8GZB5+H2yEcAKLOUHQ8yht9yX4
	 1I0LsY+CtASv7tn89qY7eof5Se28JWHBAEPVPSIXxWQUlo2E8gGugH/XLeLsgh7ZJL
	 /FSK8ihDRPFUHDNhRfJlYHU4SQbnAoPAtbv6ZF7aO6vw9sjtsL9z0okrLjiNdTeuJg
	 uRb49A1mkt0+Q==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id D51E31200068;
	Mon, 11 Mar 2024 19:41:49 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 11 Mar 2024 19:41:49 -0400
X-ME-Sender: <xms:vZbvZZV_m-NiFtZNJqpCTL9kii3KSqqi8T68ZnlVFvOXG9IKNNCkyw>
    <xme:vZbvZZlMJ7mticWirLNpP2rvE-whML_uteHdEbnb87TXPwlW2l4h1FsZ4dp1oxJlv
    U4tlalQlzplBQQ9JNE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnugih
    ucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleffgfef
    vdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudekheei
    fedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrd
    hluhhtohdruhhs
X-ME-Proxy: <xmx:vZbvZVZr-WaWklmrl9_JjElSriCYLBmB3CkUcglXRpKT6VnSBDWogg>
    <xmx:vZbvZcVjzbrUeqq7KYaAS3P8ji4pVAKVcYhVVn1t8hb2vFsueOz9zw>
    <xmx:vZbvZTk99hxyJX2oUQAb36Ug9rA7hLf5FBnIEi-MIgWLSvecAZsNqQ>
    <xmx:vZbvZebBfK40_XZRBnJczlhxDnFpZOz-7cVHg5Aglhhd5gC9CkkKqe7lbiMXvptY>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 35B0031A0065; Mon, 11 Mar 2024 19:41:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ef0419dd-9d7b-4b77-b63a-5f11aaefb570@app.fastmail.com>
In-Reply-To: <bedfa55b-b1d0-4e59-8c94-dbc5f8485a7f@intel.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com>
 <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
 <bedfa55b-b1d0-4e59-8c94-dbc5f8485a7f@intel.com>
Date: Mon, 11 Mar 2024 16:41:28 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Dave Hansen" <dave.hansen@intel.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>,
 "Christian Brauner" <brauner@kernel.org>, bristot@redhat.com,
 "Ben Segall" <bsegall@google.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, dianders@chromium.org,
 dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
 "hch@infradead.org" <hch@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
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
Content-Type: text/plain

On Mon, Mar 11, 2024, at 4:34 PM, Dave Hansen wrote:
> On 3/11/24 15:17, Andy Lutomirski wrote:
>> I *think* that all x86 implementations won't fill the TLB for a
>> non-accessed page without also setting the accessed bit,
>
> That's my understanding as well.  The SDM is a little more obtuse about it:
>
>> Whenever the processor uses a paging-structure entry as part of
>> linear-address translation, it sets the accessed flag in that entry
>> (if it is not already set).
>
> but it's there.
>
> But if we start needing Accessed=1 to be accurate, clearing those PTEs
> gets more expensive because it needs to be atomic to lock out the page
> walker.  It basically needs to start getting treated similarly to what
> is done for Dirty=1 on userspace PTEs.  Not the end of the world, of
> course, but one more source of overhead.

In my fantasy land where I understand the x86 paging machinery, suppose we're in finish_task_switch(), and suppose prev is Not Horribly Buggy (TM).  In particular, suppose that no other CPU is concurrently (non-speculatively!) accessing prev's stack.  Prev can't be running, because whatever magic lock prevents it from being migrated hasn't been released yet.  (I have no idea what lock this is, but it had darned well better exist so prev isn't migrated before switch_to() even returns.)

So the current CPU is not accessing the memory, and no other CPU is accessing the memory, and BPF doesn't exist, so no one is being utterly daft and a kernel read probe, and perf isn't up to any funny business, etc.  And a CPU will never *speculatively* set the accessed bit (I told you it's fantasy land), so we just do it unlocked:

if (!pte->accessed) {
  *pte = 0;
  reuse the memory;
}

What could possibly go wrong?

I admit this is not the best idea I've ever had, and I will not waste anyone's time by trying very hard to defend it :)

