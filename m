Return-Path: <linux-kernel+bounces-16237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBBA823B50
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271811C24BEF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 04:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E102F1096F;
	Thu,  4 Jan 2024 04:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Vyitt1y9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD321DFD8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 04:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7818487b1d3so9867885a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 20:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704340835; x=1704945635; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHbPCI0IlclsnqQXqAzIdnpwqQfcJqP5UQVQxoRN7zc=;
        b=Vyitt1y9OsNwN0Eq+SRG6genmkq7j9zIrSrbAATy6ID9LZEWsg9jN8tAS5fnK8SQO0
         8Lzn9rdpK8P4uPx8nCy1ZE7BlsSUnmsQgmh55StMsk8jmpKa6ywJv7WEZc9gLVL8ybKw
         aWafA82LfUD9il9PLNFcwrz9xz3nMB21m/QXPa99R0iHM2egl9Jvc0utoDhnoFwZ1Gdl
         nhpNRRePTwjC5Y2QINv5zP1QUPP3UtZ5FsLDvn8zZnt0YL0ykK4VqU51BMXZ844m4F6J
         6J8Q2rQkaWUxIcX1vkAWVrPTNClRfLBOWKQxAx0ZKzTPr7BKGZ7AvSlnvuMKSvreM51w
         L/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704340835; x=1704945635;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHbPCI0IlclsnqQXqAzIdnpwqQfcJqP5UQVQxoRN7zc=;
        b=o/ywUwEKeWvJvKgxuOX94eSTh+xuUaOwNJxwgeuu5BbbSrfG1zzDYpKNxWLgDWcGRE
         11jZZ4LjttfZfDZQw90bSk3eJc1d/qKPEyXuUtxZNLBjrie/xg890t0XmhDAmp9ZNJhw
         AqMrRwxRnm9e5EYENMxsZ+IWOR1erYPcHv5hAN1s5gFKONDY1ycvp7viOQrKlHlvj9lD
         wFCyNJj49odEJfrRAntklbTYUiN2pcEymJo0kZl5rU4bPNPfTWZldXM4KJS+cQVDGh2j
         N0pcspmDeGMHj5ZAYQTuXsykDWulEml7c7DNhU68WeiA2rh1d2oL3miItyZrP8LzaFmG
         Hntw==
X-Gm-Message-State: AOJu0Yw//itkiKOxAPbMXqxh1eQPsq2KHxWHWL31FlHEOklmKU5EwrGI
	8rC7ZuwtxzoHPr8xbPZE9TQIskXMnHHqp2Jfs8auLmhDQg==
X-Google-Smtp-Source: AGHT+IFmfzVczvvZTIdAIm14FL/S2jXjtloMcLLOZuSaA5xVUfkq+uzyshSOm4T+g0bZO9QsXFMziw==
X-Received: by 2002:a05:620a:2b90:b0:780:ef6e:23f6 with SMTP id dz16-20020a05620a2b9000b00780ef6e23f6mr28689qkb.123.1704340834366;
        Wed, 03 Jan 2024 20:00:34 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id pi35-20020a05620a37a300b0078199077d0asm4299330qkn.125.2024.01.03.20.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 20:00:33 -0800 (PST)
Date: Wed, 03 Jan 2024 23:00:33 -0500
Message-ID: <ffdd5e4d10865da5f767df53b12bb6db@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: "Dr. Greg" <greg@enjellic.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 2/13] Add TSEM specific documentation.
References: <20230710102319.19716-3-greg@enjellic.com>
In-Reply-To: <20230710102319.19716-3-greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Jul 10, 2023 "Dr. Greg" <greg@enjellic.com> wrote:
> 
> An entry was added to the ABI testing documentation to document
> the files in the TSEM management filesystem.
> 
> The file documenting the kernel command-line parameters was
> updated to document the TSEM specific command-line parameters
> 
> The primary TSEM documentation file was added to the LSM
> administration guide and the file was linked to the index of LSM
> documentation.
> 
> Signed-off-by: Greg Wettstein <greg@enjellic.com>
> ---
>  Documentation/ABI/testing/tsem                |  828 +++++++++
>  Documentation/admin-guide/LSM/index.rst       |    1 +
>  Documentation/admin-guide/LSM/tsem.rst        | 1526 +++++++++++++++++
>  .../admin-guide/kernel-parameters.txt         |   18 +
>  4 files changed, 2373 insertions(+)
>  create mode 100644 Documentation/ABI/testing/tsem
>  create mode 100644 Documentation/admin-guide/LSM/tsem.rst

Let me start by apologizing for the delay in responding, your patience
was appreciated.  Comments below ...

> diff --git a/Documentation/ABI/testing/tsem b/Documentation/ABI/testing/tsem
> new file mode 100644
> index 000000000000..cfb013b5f1f4
> --- /dev/null
> +++ b/Documentation/ABI/testing/tsem
> @@ -0,0 +1,828 @@
> +What:		/sys/kernel/security/tsem
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The /sys/kernel/security/tsem directory contains files
> +		and directories that implement the control plane for
> +		the Trusted Security Event Modeling (TSEM) LSM.
> +
> +		The files in this directory hierarchy, with the
> +		exception of the aggregate file, when read, reflect
> +		the values for the security modeling namespace that
> +		the process reading the files is operating in.
> +
> +What:		/sys/kernel/security/tsem/id
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The id file contains the ASCII base 10 representation
> +		of the model domain/namespace identifier that the
> +		reading process is operating in.
> +
> +		The root security modeling namespace has a value of
> +		zero, a non-zero value indicates a modeling namespace
> +		subordinate to the root model.
> +
> +		Each externally modeled domain will have a file, with
> +		this id number, created in the
> +		/sys/kernel/security/tsem/ExternalTMA directory that
> +		is documented below.

Just making sure you want to use uppercase here.  It's your call,
but it tends to go against convention, and changing it after the code
is in a tagged release it painful enough that it should be considered
practically impossible.  This applies not just to this file, but all
of the other mixed/upper case TSEM files under /sys.

> +What:		/sys/kernel/security/tsem/aggregate
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The aggregate file contains the ASCII base 16
> +		representation of the 256 bit hardware platform
> +		aggregate that TSEM is modeling under.  The platform
> +		aggregate is the linear extension measurement of the
> +		Trusted Platform Module PCR registers 0 through 8.

I believe we talked about hash agility previously, but just in case,
you may want to reword the above to provide some flexibility around
the hash algorithm used.  On the other hand, if you want to stick
with a single hash algorithm and 256-bit digest length, you might as
well specify the hash algorithm here.  I don't want to assume too much
about the TSEM design, but I'm guessing the aggregate is intended to
be a deterministic value based on the PCRs and therefore it seems like
there is value in providing a clear explanation of how it is
calculated.

> +		On a platform without a TPM this value will be all
> +		null bytes.

Just to clarify, are you intending this to be NULL bytes (as written)
or an ASCII base 16 zero value, padded out to the digest length,
similar as to what you might see in the output of the `tpm2_pcrread`
command for a zero-value PCR?  Once again, it's your call, I just
wanted to clarify.

> +What:		/sys/kernel/security/tsem/control
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The control file is the only writable file in the
> +		filesystem and is used by the trust orchestrator's to
> +		configure and control the behavior of the TSEM
> +		implementation.

I would drop the "only writable file ..." portion above; it may be the
only writable file under /sys/kernel/security/tsem at the moment, but
I imagine there is a good chance that will change over time and the
comment doesn't really add anything important.

> +		The following keyword and arguments are recognized:
> +
> +		internal
> +			The internal keyword causes an internally
> +			modeled domain to be created for the calling
> +			process.
> +
> +		external
> +			The external keyword causes an externally
> +			modeled domain to be created for the calling
> +			process.
> +
> +			A modeling namespace created by these commands
> +			accept the following set of key=value pairs
> +			that configure the namespace:

I assume whitespace is used as a delimiter?  That would be good to
document, both between the key-value-pairs as well as the initial
op/keyword.

Also, do these key-value-pairs apply to both internal and external
domains?  The text seems to indicate that they do, but the way the
document is structured hints that they only apply to the external
domain.  Perhaps a sentence in the internal domain description
indicating that all of the external domain configuration parameters
apply to internal domains as well, unless explicitly stated otherwise.

> +			nsref=initial|current
> +				The nsref key specifies the namespace
> +				that is to be referenced when
> +				determining the UID/GID values that
> +				define a COE or CELL identity.

Are COE or CELL acronyms?  If so, it would be nice to expand them on
first use in the document.

> +				The initial keyword specifies that the
> +				initial user namespace be used.  The
> +				current keyword specifies that the
> +				user namespace of the process that is
> +				invoking a security event handler
> +				(hook) is used.
> +
> +			digest=digestname
> +				The digest key is used to specify the
> +				cryptographic hash function that is to
> +				be used in the namespace for the
> +				creation of COE and CELL identities.
> +
> +				The digestname is the name used by the
> +				Linux kernel cryptographic API to
> +				identify the hash function.  Examples
> +				would include sha256, sha3-256, sm3
> +				etc.  The source files for the
> +				cryptographic hash function in the crypto
> +				directory of the kernel source has the
> +				names for hash functions implemented
> +				in the kernel.
> +
> +				The sha256 hash function is the
> +				default function for the root modeling
> +				domain.  This can be modified by the
> +				tsem_digest command-line parameter.
> +
> +				A hash function, used by the root
> +				modeling domain, must be built into
> +				the kernel.
> +
> +			cache=NN
> +				The cache key specifies the size of
> +				the caches to be used for holding
> +				pointers to structures used for the
> +				modeling or export of security events
> +				that are called while the invoking
> +				process is in atomic context.
> +
> +				The value NN is the ASCII base 10
> +				representation of the number of
> +				entries in the cache.
> +
> +				By default, the root modeling
> +				namespace and an externally modeled
> +				namespace will have 96 entries.  An
> +				internally modeled namespace will have
> +				16 entries.
> +
> +			key=HEXID
> +				The key argument is used to specify
> +				the authentication key that will be
> +				used by a trust orchestrator to
> +				authenticate trust control requests to
> +				a process running in the security
> +				modeling namespace.
> +
> +				The HEXID value is the ASCII base16
> +				encoded key that is to be used.  The
> +				length of this key, in binary, must be
> +				equal to the size of the digest
> +				produced by the cryptographic hash
> +				function that is being used in the
> +				modeling namespace.
> +
> +		enforce
> +			The enforce keyword causes the modeling
> +			domain/namespace of the process to enter
> +			enforcing mode.  In this mode, a value of
> +			-EPERM will be returned for a security event
> +			coefficient that does not map into the current
> +			set of allowed coefficients for the security
> +			model being implemented in the namespace.
> +
> +		seal
> +			The seal keyword causes the security model
> +			being implemented for the namespace to be
> +			placed in a sealed state.  In this state, the
> +			current set of security coefficients is
> +			considered to be the only set of valid
> +			coefficients for the model.  Any subsequent
> +			events that map to a coefficient not in the
> +			current model will be considered a violation
> +			of the model.
> +
> +		trusted pid=PID key=HEXID
> +			The trusted keyword is used by a trust
> +			orchestrator to indicate that the process
> +			identified by the PID argument should be
> +			allowed to run in trusted status after the
> +			modeling of a security event.

I mentioned this quite a few times in my review of the previous
patchset, PIDs are not a safe way to identify a process in the system.
PID reuse/recycling is a real danger and you need to account for this
risk.

> +			The HEXID argument is the authentication key
> +			that has been configured by a trust
> +			orchestrator for the namespace at the time of
> +			its creation.
> +
> +		untrusted pid=PID key=HEXID
> +			The untrusted keyword is used by a trust
> +			orchestrator to indicate that the process
> +			identified by the PID argument should be
> +			designated as an untrusted process.

See above, you can't use a PID to safely identify a process.

> +			The HEXID argument is the authentication key
> +			that has been configured by a trust
> +			orchestrator for the namespace at the time
> +			its creation.
> +
> +		state value=HEXID
> +			The state keyword is used to indicate that the
> +			security state coefficient identified by the
> +			ASCII base 16 encoded value specified by HEXID
> +			should be loaded into the current security
> +			model as a valid security event coefficient.
> +
> +		pseudonym valid=HEXID
> +			The pseudonym keyword is used to indicate that
> +			the pathname, identified by the ASCII base 16
> +			encoded value HEXID, should be designated to
> +			return a constant digest value for the
> +			contents of the file named by the pseudonym.
> +
> +			The HEXID value is computed with the following
> +			function:
> +
> +			HEXID = HF(PATHNAME_LENGTH || PATHNAME)
> +
> +			WHERE HF is the cryptographic hash function
> +			that has been designated for use by the
> +			security modeling namespace.

How do you handle hash collisions?  Given that users will likely be
able to create files with arbitrary names, it seems like identifying
files by a hash of their pathname without any way to safely resolve
digest collisions is a problem in waiting.

> +		base value=HEXID
> +			The base keyword is used to indicate that the
> +			ASCII base 16 encoded value HEXID should be
> +			registered as the value used to generate
> +			security state coefficients for the model
> +			implemented in the modeling namespace.
> +
> +			The binary length of the value specified by
> +			HEXID must match the digest size of the
> +			cryptographic hash function specified for use
> +			in the security modeling namespace.
> +
> +			A model specific base value is designed to be
> +			used as a 'freshness' nonce, similar to an
> +			attestation nonce, to prove that a model state
> +			value or measurement is current and not being
> +			replayed.
> +
> +What:		/sys/kernel/security/tsem/InternalTMA
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +
> +		This directory will contain directories that will be
> +		used to hold files that surface model parameters for
> +		Trusted Modeling Agents (TMA's) for internally modeled
> +		security namespaces.
> +
> +		There is currently only one internal TMA that is
> +		surfaced through the following directory:
> +
> +		/sys/kernel/security/tsem/InternalTMA/model0
> +
> +		The subsequent descriptions for the files implemented
> +		in this directory will use ROOTDIR to represent the
> +		above directory for space conservation purposes.
> +
> +What:		ROOTDIR/measurement
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The measurement file contains the ASCII base 16
> +		representation of the time dependent linear extension
> +		value of all the security state coefficients in the
> +		model implemented by the namespace of the calling
> +		process.

If I remember correctly, one of the motivations for TSEM was to
avoid the time/ordering aspect of traditional attestation approaches
as it can be fragile.  Assuming that my memory is correct, and this
still holds true in the revision of the patchset, why are you
continuing to export time/order dependent measurements to userspace?

Either the ordering is important, in which case TSEM's novelty isn't
useful, or the ordering isn't important and we can remove this sysfs
file.

> +What:		ROOTDIR/state
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The state file contains the ASCII base 16
> +		representation of the functional value of a security
> +		modeling namespace.
> +
> +		The state value is a time independent representation
> +		of the measurement of a security model, and unlike the
> +		measurement value, is a time independent
> +		representation of the state.
> +
> +		This value is designed to be a single value that can
> +		be attested to represent whether or not a workload has
> +		deviated from a defined security behavior.

Continuing the comment above regarding ROOTDIR/measurement, this file
makes much more sense in the context of TSEM.

> +What:		ROOTDIR/trajectory
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The trajectory file contains a description of the
> +		security events that have occurred in a security
> +		modeling namespace
> +
> +		Each entry in this file represents a single security
> +		event and consists of a JSON encoded record with key
> +		values that define the characteristics of the event.
> +
> +		Each line in a trajectory, or forensics, file will
> +		always have the event and COE keys.  The event key
> +		describes the characteristics of a security event
> +		while the COE field describes the Context Of Execution
> +		that is requesting execution of a security event.
> +
> +		The event key consists of the following
> +		characteristic definitions:
> +
> +			process: COMM
> +				Where COMM is the ASCII representation
> +				of the name of the process executing
> +				the event.

What happens if a process, either innocently or maliciously, changes
its name (see prctl(PR_SET_NAME))?  Would it result in a mismatch of
the security state of a process?

> +			type: EVENT_TYPE
> +				The value field for a type key is the
> +				name of the security event that is
> +				being modeled.  The list of EVENT_TYPE
> +				names is defined in the following
> +				source file:
> +
> +				security/tsem/tsem.c
> +
> +				If the security event is a generically
> +				modeled event the EVENT_TYPE will be
> +				generic_event.  In this case the CELL
> +				characteristics for the event will be
> +				described by a generic_event: key

I'm guessing EVENT_TYPE is an ASCII string representation?  It would
be good to clarify as you have in most (all?) of the other fields and
the omission here raises a red flag.

> +			task_id: HEXID
> +				The value of the task_id key will the
> +				ASCII base 16 representation of the
> +				identity of the task that is executing
> +				the security handler.  The length of
> +				HEXID will match the size of the
> +				digest value of the cryptographic hash
> +				function selected for use by the
> +				security modeling namespace.
> +
> +				The following documentation file:
> +
> +				Documentation/admin-guide/LSM/TSEM.rst

It looks like the file is lowercase ".../tsem.rst".

> +				Describes how the TASK_ID value is
> +				generated.

I would suggest either moving or copying the TASK_ID definition here
so that it is included in the TSEM ABI document.

> +		The COE key has the following characteristic keys.
> +		Keys that involve discretionary access values
> +		(uids/gids) will have their numeric value computed
> +		based on the user namespace reference value that is
> +		being implemented in the security modeling namespace.
> +
> +			uid: NN
> +				The ASCII base 10 representation of
> +				the numeric value of the discretionary
> +				user id of the process that is
> +				executing the security event.
> +
> +			euid: NN
> +				The ASCII base 10 representation of
> +				the numeric value of the effective
> +				discretionary user id of the process
> +				that is executing the security event.
> +
> +			euid: NN
> +				The ASCII base 10 representation of
> +				the numeric value of the effective
> +				discretionary user id of the process
> +				that is executing the security event.
> +
> +			suid: NN
> +				The ASCII base 10 representation of
> +				the numeric value of the saved user id
> +				of the process that is executing the
> +				security event.
> +
> +			gid: NN
> +				The ASCII base 10 representation of
> +				the numeric value of the discretionary
> +				group id of the process that is
> +				executing the security event.
> +
> +			egid: NN
> +				The ASCII base 10 representation of
> +				the numeric value of the discretionary
> +				effective group id of the process that
> +				is executing the security event.
> +
> +			egid: NN
> +				The ASCII base 10 representation of
> +				the numeric value of the discretionary
> +				effective group id of the process that
> +				is executing the security event.
> +
> +			sgid: NN
> +				The base 10 ASCII representation of
> +				the numeric value of the saved
> +				discretionary group id of the process
> +				that is executing the security event.
> +
> +			fsuid: NN
> +				The base 10 ASCII representation of
> +				the numeric value of the discretionary
> +				filesystem user id of the process that
> +				is executing the security event.
> +
> +			fsgid: NN
> +				The ASCII base 10 representation of
> +				the numeric value of the discretionary
> +				filesystem group id of the process
> +				that is executing the security event.
> +
> +			capeff: 0xNNN
> +				The ASCII base 16 representation of
> +				the numeric value of effective
> +				capabilities of the process that is
> +				executing the security event.
> +
> +		If the CELL value for a security event includes the
> +		definition of a file a file: key value will be
> +		included.  The following characteristics will be
> +		encoded in this field:
> +
> +			flags: NN
> +				The ASCII base 10 representation of
> +				the flags value of the 'struct file'
> +				structure that is the source of the
> +				file description.
> +
> +			uid: NN
> +				The ASCII base 10 representation of
> +				the discretionary user id of the file.
> +
> +			gid: NN
> +				The base 10 ASCII representation of
> +				the discretionary group id of the
> +				file.
> +
> +			mode: 0NNN
> +				The ASCII base 8 representation of the
> +				mode bits of the file.

Does the leading zero followed by three octets imply you don't record
the setuid/setgid/sticky bits?

> +			name_length: NN
> +				The ASCII base 10 representation of
> +				the length of the pathname that will
> +				be encoded in the name= characteristic.

To clarify, this is the length of the pathname used during the file
lookup and not the length of the hash digest of the previously
mentioned pathname, yes?

> +			name: NN
> +				The ASCII hexadecimal representation
> +				of the SHA256 checksum of the pathname
> +				of the file that is pre-pended with
> +				the little-endian binary value of the
> +				length of the pathname.

Hash agility?

It isn't clear to me if the length is prepended before or after the
hash, it would be good to clean this up.

Also, similar to some comments above, how are you handling hash
collisions?  As pathnames can be influenced by unprivileged users, this
would appear to be an issue.

> +			s_magic: 0xNN
> +				The ASCII base 16 representation of the
> +				magic number of the filesystem that
> +				contains the file.
> +
> +			s_id: NAME
> +				The ASCII name of the block device for
> +				the filesystem that contains the file.
> +
> +			s_UUID: HEX
> +				The ASCII base 16 representation of
> +				the hexadecimal value of the UUID of
> +				the filesystem that contains the file.
> +
> +			digest: HEX
> +				The ASCII base 16 representation of
> +				the SHA256 digest of the file.

Hash agility?

Is TSEM running a hash over every file included in a file-related
security event?

> +		If the event type is the memory mapping of a file a
> +		mmap_file key value will be included with
> +		the following characteristics:

Still part of the CELL?  COE?  This doc could benefit from better
explanations of the CELL and COE terms.

> +			type: N
> +				Where N is an ASCII 0 or 1 to indicate
> +				whether or not the mapping is file
> +				backed or anonymous.  A value of 1 is
> +				used to indicate an anonymous mapping.
> +
> +			reqprot: NN
> +				Where N is ASCII base 10
> +				representation of the protections
> +				requested for the mapping.
> +
> +			prot: NN
> +				Where N is the ASCII base 10
> +				representation of the protections that
> +				will be applied to the mapping.
> +
> +			flags: NN
> +				Where N is the ASCII base 10
> +				representation of the flags that will
> +				be used for the memory mapping operation.

You should specify the flags used in the fields above, or refer
readers to the mmap(2) flag definitions if appropriate.

> +		If the event type is a socket creation event a
> +		socket_create key value will be included with the
> +		following characteristics:
> +
> +			family: N
> +				Where N is the ASCII base 10
> +				representation of the family type of
> +				the socket.
> +
> +			type: N
> +				Where N is the ASCII base 10
> +				representation of the type of socket
> +				being created.
> +
> +			protocol: N
> +				Where N is the ASCII base 10
> +				representation of the protocol family
> +				for the socket.

Similar to the mmap flags above, I would refer people to where these
values are defined.  The applies to the other socket family/type/proto
fields described elsewhere in this document.

> +			kern: 0 | 1
> +				Where 0 or 1 is used to indicate
> +				whether or not the socket is kernel
> +				based.  A value of 1 implies it is
> +				kernel based.

I'm curious how TSEM would distinguish between different kernel
socket events.  I would expect most kernel sockets to share the same
event key (COE/CELL/etc.), is that not the case?

> +		If the event type is a socket_connect or a
> +		socket_bind, a socket_connect: or a socket_bind: key
> +		value will be included that will be characterized
> +		based on an encoding of either an IPV4, IPV6, AF_UNIX
> +		or a generic socket description.
> +
> +			family: N
> +				Where N is the ASCII base 10
> +				representation of the family type of
> +				the socket.
> +
> +			port: N
> +				Where N is the base ASCII base 10
> +				representation of the port number that
> +				is being used for either an IPV4 or
> +				IPV6 socket connection or bind.
> +
> +			addr: N | PATH | HEXID
> +				In the case of an IPV4 socket the
> +				value for the addr key will be the
> +				ASCII base 10 representation of the 32
> +				bit IPV4 address being bound or
> +				connected to.
> +
> +				In the case of an IPV6 connection the
> +				value to the key will be the ASCII
> +				base 16 representation of the 128 bit
> +				address being bound connected.
> +
> +				In the case of an AF_UNIX connection
> +				the value will be the pathname of the
> +				socket in the mount namespace that the
> +				process is running in.
> +
> +				In the case of any other type of
> +				socket the addr value will be the
> +				ASCII base 16 representation of the
> +				cryptographic digest value of the
> +				entire length of the address
> +				description.  The length of the
> +				representation will be the size of the
> +				digest produced by the cryptographic
> +				hash function that has been specified
> +				for the modeling namespace.
> +
> +			flow: N
> +				For an IPV6 socket the value of the
> +				flow key will be the ASCII base 10
> +				representation of the flow identifier
> +				assigned to the socket.
> +
> +			scope: N
> +				For an IPV6 socket the value of the
> +				scope key will be the ASCII base 10
> +				representation of the scope identifier
> +				assigned to the socket.

What will "flow" and "scope" be for non-AF_INET6 sockets?  You need
to specify that here.

> +		If the event type is a socket_accept a socket_accept
> +		key value will be included that characterizes either
> +		an IPV4, IPV6 or a generic socket description with the
> +		following event descriptions:
> +
> +			family: N
> +				Where N is the ASCII base 10
> +				representation of the family type of
> +				the socket.
> +
> +			type: N
> +				Where N is the ASCII base 10
> +				representation of the type of the
> +				socket being created.
> +
> +			port: N
> +				Where N is the base ASCII base 10
> +				representation of the port number that
> +				is being used for either an IPV4 or
> +				IPV6 socket connection or bind.
> +
> +			addr: N | PATH | HEXID
> +				In the case of an IPV4 socket the
> +				value for the addr key will be the
> +				ASCII base 10 representation of the 32
> +				bit IPV4 address being bound or
> +				connected to.
> +
> +				In the case of an IPV6 connection the
> +				value to the key will be the ASCII
> +				base 16 representation of the 128 bit
> +				address being bound connected.
> +
> +				In the case of an AF_UNIX connection
> +				the value will be the pathname of the
> +				socket in the mount namespace that the
> +				process is running in.
> +
> +				In the case of any other type of
> +				socket the addr value will be the
> +				ASCII base 16 representation of the
> +				cryptographic digest value of the
> +				entire length of the address
> +				description.  The length of the
> +				representation will be the size of the
> +				digest produced by the cryptographic
> +				hash function that has been specified
> +				for the modeling namespace.
> +
> +What:		ROOTDIR/trajectory_coefficients
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The trajectory_coefficients file will output the ASCII
> +		base16 representation of each security state
> +		coefficient that has been generated by the security
> +		modeling namespace of the calling process.
> +
> +		The length of each point will be the ASCII
> +		representation of the size of the cryptographic hash
> +		function that has been specified for the model.

Is this just the ROOTDIR/trajectory JSON in ASCII hex, or something
different?

> +What:		ROOTDIR/trajectory_counts
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The trajectory_coefficients file will output the ASCII
> +		base10 representation of the number of times each

Unless I'm mistaken, I believe you defined it as base16 above ... ?

> +		security state coefficient has been generated by the
> +		security modeling namespace of the calling process.

This looks like an old cut-n-paste error.  I'm guessing this file
reports on the number of coefficients in ASCII base10?

> +What:		ROOTDIR/forensics
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The forensics file contains the descriptions of
> +		security events that are inconsistent with the
> +		security model that the security namespace is
> +		implementing.  Forensics events are generated after a
> +		security model is 'sealed' and the events represent
> +		security state coefficients that have not already been
> +		generated by the model.
> +
> +		The format of lines in this file are identical to the
> +		output generated by the ROOTDIR/trajectory file
> +		that is documented above.
> +
> +What:		ROOTDIR/forensics_coefficients
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The forensics_coefficients file will output the ASCII
> +		base16 representation of each security state
> +		coefficient that have been generated by forensics
> +		events in the security modeling namespace of the
> +		calling process.
> +
> +		The length of each point will be the ASCII
> +		representation of the size of the cryptographic hash
> +		function that has been specified for the model.
> +
> +What:		ROOTDIR/forensics_counts
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The forensics_counts file will output the ASCII base10
> +		representation of the number of times each security
> +		state coefficient, generated by a forensics event, has
> +		been generated by the security modeling namespace of
> +		the calling process.
> +
> +What:		/sys/kernel/security/tsem/ExternalTMA
> +Date:		July 2023
> +Contact:	Greg Wettstein <greg@enjellic.com>
> +Description:
> +		The ExternalTMA directory is a container directory
> +		that hold files that will be used to export the
> +		security events, and their associated parameters, for
> +		externally modeled security modeling namespaces.
> +
> +		The files created in this directory will be named by
> +		the base 10 ASCII representation of the id value
> +		assigned to the security modeling namespace.  See the
> +		documentation for the /sys/kernel/security/tsem/id
> +		file in this documentation for more details on this
> +		value.
> +
> +		This file will is a read-only file that can be polled
> +		by a userspace trust orchestrator implementation to
> +		process security events that are to be modeled by an
> +		external Trusted Modeling Agent.
> +
> +		Each exported event is a JSON encoded record
> +		describing the event that is to be processed.
> +
> +		Each record will have an 'export' key that has a
> +		structure associated with it that has a 'type' key in
> +		it.  The 'type' key has a string value associated with
> +		it that defines the type of event that is being
> +		processed.
> +
> +		The following export 'type' strings are defined:
> +
> +		aggregate:
> +			The aggregate key has an associated structure
> +			value that defines a key named 'value' that
> +			has a string value associated with it that
> +			represents the hardware aggregate for the
> +			platform.

You need to define "hardware aggregate" here, if you can't go into
detail you need a good summary outlining its security relevant
properties.

> +			The hardware aggregate string is expressed as
> +			the ASCII base16 representation of the
> +			platform hardware aggregate value.  The length
> +			of the string will be the size of the digest
> +			produced by the cryptographic hash function
> +			that has been specified for the security
> +			modeling namespace of the process generating
> +			the event.
> +
> +		async_event:
> +			If the type of the export is async_event there
> +			will be a key named 'event' that has a structure
> +			value associated with it.
> +
> +			The structure associated with the 'event' key
> +			will be identical to the structure generated
> +			for the 'event' key that is described below.
> +
> +		event:
> +			If the type of the export is event there will
> +			be a key named 'event' that has a structure
> +			value associated with it that contains the
> +			follow key: value pairs.
> +
> +			pid: NNN
> +				Where the NNN is the ASCII base 10
> +				value of the id of the process that is
> +				executing the security event that will
> +				be modeled.

Once more, you can't use a PID to safely identify a process.

We discussed the PID reuse problem in the previous draft of TSEM and
you seem confident that this revision would solve the problem,
unfortunately I don't believe that to be the case.  Perhaps the code
is sound and the documentation is lagging/incorrect, but the doc
appears to be consistent enough in this area that I don't believe that
to be the case.  Before I can spend any more time looking at TSEM I
need to understand how it handles PID recycling.

I'm also concerned that it appears pathname digests, as opposed to the
pathnames themselves, are being used to help uniquely identify
security events.  Relying on pathnames unique identification can
already be a challenge, relying on a hashed pathname without any
provisions to manage/mitigate collisions seems like an attack waiting
to happen.  Please provide some additional explanations as to why
this is not a concern.

> +			process: COMM
> +				Where COMM is the ASCII representation
> +				of the name of the process executing
> +				the event.
> +
> +			type: EVENT_TYPE
> +				The value field for a type key is the
> +				name of the security event that is
> +				being modeled.  The list of EVENT_TYPE
> +				names is defined in the following
> +				source file:
> +
> +				security/tsem/tsem.c
> +
> +				If the security event is a generically
> +				modeled event the EVENT_TYPE will be
> +				generic_event.  In this case the CELL
> +				characteristics for the event will be
> +				described by a generic_event: key
> +
> +			task_id: HEXID
> +				The value of the task_id key will the
> +				ASCII base 16 representation of the
> +				identity of the task that is executing
> +				the security handler.  The length of
> +				HEXID will match the size of the
> +				digest value of the cryptographic hash
> +				function selected for use by the
> +				security modeling namespace.
> +
> +				The following documentation file:
> +
> +				Documentation/admin-guide/LSM/TSEM.rst
> +
> +				Describes how the TASK_ID value is
> +				generated.
> +
> +			There will be a COE key that references a
> +			value structure that has the same format as
> +			the COE key that is emitted for a trajectory
> +			or forensics event.
> +
> +			The record will have a key value that is
> +			identical to the value associated with the
> +			'type' key documented above.  The 'type' key
> +			will have a structure value that contains a
> +			definition of the event.  The definitions for
> +			the event will be identical to the description
> +			of the event that is emitted for a trajectory
> +			or forensics event in the internal TMA
> +			implementation.
> +
> +		log:
> +			An export type of log is emitted when an
> +			untrusted task attempts to execute a security
> +			event.
> +
> +			There will be a 'log' key in the record that
> +			references a structure containing the
> +			following key values:
> +
> +			process: COMM
> +				The process key has a string value
> +				associated with it that will contain
> +				the COMM name of the untrusted process
> +				that invoked processing of the
> +				security event.
> +
> +			event: NAME
> +				The event key has a string value
> +				associated with that will contain the
> +				name of the security event hook that
> +				was called by an untrusted process.
> +
> +				The names for the security events are
> +				defined in the following source file:
> +
> +				security/tsem/tsem.c
> +
> +			action: TYPE
> +				The action key has a string value that
> +				describes the action take by the TSEM
> +				security hook in response to being
> +				called by an untrusted process.
> +
> +				This string value will be either LOG
> +				or DENY.
> +SEM is premised on the theory that kernel security architects have
> +instrumented the LSM security event hooks to be called from all
> +locations, with appropriate descriptive parameters, that are relevant
> +to the security posture of the kernel.  With respect to modeling, the
> +security event hooks are conceptualized as representing the
> +independent variables of a basis set that yields a functional
> +definition for the security state of an execution trajectory.
> +
> +SEM can be framed in the context of classic subject/object mandatory
> +access controls, by the notion that a unique identity can be generated
> +for each element of an access vector matrix, rather than a boolean
> +value.  In SEM, a security execution trajectory is defined by the set
> +of security state coefficients that a process hierarchy (workload)
> +generates.  This execution trajectory produces a vector of identities,
> +whose sum in an appropriate form, yields a functional definition of
> +the security state of the system.
> +
> +Two subordinate identities are combined to yield a security event
> +state coefficient.  These subordinate identities are referred to as the
> +Context Of Execution (COE) and the CELL, which are conceptually
> +similar to the subject and object in mandatory access control.  The
> +COE identity is derived from the parameters that describe the security
> +relevant characteristics of a process, while the CELL value is derived
> +from the parameters used by a security event hook to describe the
> +characteristics of the event.
> +
> +A security policy is implemented by a modeling algorithm that
> +translates COE and CELL event parameters into their respective
> +identities.  The COE and CELL are combined to yield a security state
> +coefficient that uniquely describes the security event in the security
> +model.  Different security policies and criteria can be developed by
> +modifying how the modeling algorithm utilizes the COE and CELL
> +characteristics.
> +
> +Since the security policy is implemented with a modeling algorithm, a
> +single platform can support multiple and arbitrary security policies.
> +The equivalent of a resource namespace in SEM is referred to as a
> +security modeling namespace.
> +
> +The formation of the security state coefficients from existing kernel
> +parameters eliminates the need for the use of extended attributes to
> +hold security label definitions.  In SEM, a cryptographically signed
> +security model definition, designed to be interpreted by a modeling
> +algorithm, becomes the bearer's token for the security of the modeled
> +workload, rather than information encoded in filesystem security
> +attributes.
> +
> +Trusted Security Event Modeling
> +===============================
> +
> +	"Do you see over yonder, friend Sancho, thirty or forty
> +	 hulking giants?  I intend to do battle with them and slay
> +	 them."
> +				- Don Quixote
> +
> +In TSEM, the modeling algorithm is implemented in an entity known as a
> +Trusted Modeling Agent (TMA), in a 'trusted' environment where
> +modeling is immune from modification or alteration by any activity on
> +the platform or in a workload.  The notion of a TMA provides a
> +framework for next generation security co-processors that extend
> +functionality beyond what is defined by the concept of a Trusted
> +Platform Module (TPM).
> +
> +In addition to providing an attestation of an execution trajectory, a
> +TMA, in contrast to a TPM, has the ability to advise an operating
> +system on whether or not an event being modeled is consistent with the
> +security model that is being enforced.  In this manner, it introduces
> +a prospective rather than a retrospective trust model.
> +
> +TSEM is designed to support Trust Orchestration Systems (TOS).  In a
> +TOS, the trust orchestrators are supervisory programs that run
> +workloads in independent modeling namespaces , enforcing a workload

{snip}

--
paul-moore.com

