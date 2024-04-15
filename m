Return-Path: <linux-kernel+bounces-145044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065838A4EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC03A280EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0456D1B3;
	Mon, 15 Apr 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enPB6dNX"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C838B6CDC5;
	Mon, 15 Apr 2024 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183121; cv=none; b=OMuscPVKgKe8MRO0OPSqGEgOKBezAMeqbGp7cZpeNAqRVPvwXOmIlFN7y0wkLcOMAziy9k8AmwERR2o6KPhdX/+57AX/eyCHfkIEjQaxLj+OGUXsJwWspCarbX+7yEFur4E5HkDyVXnB5VcISK9Kx0SZSJLMyDVWHVCiHiStf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183121; c=relaxed/simple;
	bh=oc5cZfhLU2/8WG9Q5VOh/Ax10RoVEBWRKfJ9Xl2s5rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhnJT+bXZPovpDyz6c6zwXHY5TprOLKmfnphF20ywXoCX1fSfl/LcqHP6BCBAfGyAghpgBkj1eh0tTx0WdIZ53oH9e156kvyB3N2jYYzDMn+D5aSryHtROBTBY+daccQUR1u6U5yl+nUj9hadztl8XOoFOc1QFgXeV/dv9nFuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enPB6dNX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so1676319a91.3;
        Mon, 15 Apr 2024 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713183117; x=1713787917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynmP5FViOgNmd31uR0G2JNWXxSb1bA9K+sE/5arA1Wo=;
        b=enPB6dNXhOeLfYYUYqiI7eyfWG2e5yAXrS1oEWO0bF8qG5+myr0THnmhBJbrGNUaTn
         O8WkborHaRXwSl/f0vSgY4Afw6XrAKoL4mYivz/0iy/CbsSGdMxLQjnPmydWL1R2yl5C
         p8B25OtoZnScg5dMTA/Ygavg7bHoQAXUm7ZqtDv66FAExvxg4xit+geXbuify/4X3h0p
         KuesSi4ZrWNDjZMenVasn7hHR/F7sHAxGGllS9fECoTTUdEaBbCLJBWb8eCQTBlCnZdi
         i5qctCJvd33/+v4tdcb2asNuQv3qX/EFsXNuX0q43LpN454EnyLEXMsg6oxwoCGdhaUS
         YXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713183117; x=1713787917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynmP5FViOgNmd31uR0G2JNWXxSb1bA9K+sE/5arA1Wo=;
        b=hjY6uOt/KbxRNFuuBVL4DS3ZW/y9QlGBcSJVVbSGFAn/quFvgYTzImZ7QHHO9AkXn2
         MHaR5zC6PjY9LlohAfkghbwfexwHAjmop+iWAhI3fPERZL42xNMrOPwqLjglVvBRi1tO
         ze+la2uxdrrH6QpcwL7Rxah8aaJK5bM5kMKwcWH3OdJx8Z95hd6ODHnM1+RkSt4b+2pj
         mDLRF5nUIVN6drKWr083sM6MAgpeIB+qi1NJxi0GFDycLlOb1/z3JHjmieWI2z5Ze8zg
         7pAP3kg3PGyqHBadnU5xB30IkgjcAuhFyeXuT4UCH/mmmHO/q4P+7cgKEwslcph7D0/F
         5ApA==
X-Forwarded-Encrypted: i=1; AJvYcCW/I0JL3pdffTQpmhgkyOROIBUvUwhOOJR9xbwqhV/LTKTeDT7P9AfHASfCwliPMjUbGuwmMI4mC4snKVkBw4tRkp41KpNNwYQf8oDhlMeSe7oo63v0Fd0emuC24tK7aAlxEIDSn2OLdF49W00up/Fue10/djgrl9pUUhlTm/xsFyg98QWBF0PhImhFMlklcNens8/VzrWg2cwcfCLMmBzvPfW+mQlLTOZT/SU0c5D5Wut+lexLlyVeQ9+WPYVLvnIcBNZaCFE5Ig==
X-Gm-Message-State: AOJu0YzpWK7Kt2GgvXRKhIFNJzD4Rd87FduQqftSra203J+cvd+HhxKJ
	QTuZOf6BKGef6P79IIiE21vx8fegX1gjW1k2VPmPNoyCRGkmV5xN
X-Google-Smtp-Source: AGHT+IFuVa31jz+5H+lUUe9kxYp+crnauK/sEA7lk2yJ0Sewhb2eDgM92bjswJzyVhabj8MXuWuFmA==
X-Received: by 2002:a17:90b:4b45:b0:2a2:9464:f58 with SMTP id mi5-20020a17090b4b4500b002a294640f58mr8055995pjb.49.1713183116220;
        Mon, 15 Apr 2024 05:11:56 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 42-20020a17090a09ad00b002a2a3aebb38sm7716380pjo.48.2024.04.15.05.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:11:55 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 29FD6182D8BC3; Mon, 15 Apr 2024 19:11:52 +0700 (WIB)
Date: Mon, 15 Apr 2024 19:11:51 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com,
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu,
	ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com,
	snitzer@kernel.org, eparis@redhat.com, paul@paul-moore.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v17 20/21] Documentation: add ipe documentation
Message-ID: <Zh0Zh3-xraVl85Lm@archie.me>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
 <1712969764-31039-21-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="skOkNqw6jHEQ6Ykp"
Content-Disposition: inline
In-Reply-To: <1712969764-31039-21-git-send-email-wufan@linux.microsoft.com>


--skOkNqw6jHEQ6Ykp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 05:56:03PM -0700, Fan Wu wrote:
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-=
guide/LSM/ipe.rst
> new file mode 100644
> index 000000000000..d2bdd6e5b662
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -0,0 +1,797 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Integrity Policy Enforcement (IPE)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. NOTE::
> +
> +   This is the documentation for admins, system builders, or individuals
> +   attempting to use IPE. If you're looking for more developer-focused
> +   documentation about IPE please see Documentation/security/ipe.rst
> +
> +Overview
> +--------
> +
> +Integrity Policy Enforcement (IPE) is a Linux Security Module that takes=
 a
> +complementary approach to access control. Unlike traditional access cont=
rol
> +mechanisms that rely on labels and paths for decision-making, IPE focuses
> +on the immutable security properties inherent to system components. These
> +properties are fundamental attributes or features of a system component
> +that cannot be altered, ensuring a consistent and reliable basis for
> +security decisions.
> +
> +To elaborate, in the context of IPE, system components primarily refer to
> +files or the devices these files reside on. However, this is just a
> +starting point. The concept of system components is flexible and can be
> +extended to include new elements as the system evolves. The immutable
> +properties include the origin of a file, which remains constant and
> +unchangeable over time. For example, IPE policies can be crafted to trust
> +files originating from the initramfs. Since initramfs is typically verif=
ied
> +by the bootloader, its files are deemed trustworthy; "file is from
> +initramfs" becomes an immutable property under IPE's consideration.
> +
> +The immutable property concept extends to the security features enabled =
on
> +a file's origin, such as dm-verity or fs-verity, which provide a layer of
> +integrity and trust. For example, IPE allows the definition of policies
> +that trust files from a dm-verity protected device. dm-verity ensures the
> +integrity of an entire device by providing a verifiable and immutable st=
ate
> +of its contents. Similarly, fs-verity offers filesystem-level integrity
> +checks, allowing IPE to enforce policies that trust files protected by
> +fs-verity. These two features cannot be turned off once established, so
> +they are considered immutable properties. These examples demonstrate how
> +IPE leverages immutable properties, such as a file's origin and its
> +integrity protection mechanisms, to make access control decisions.
> +
> +For the IPE policy, specifically, it grants the ability to enforce
> +stringent access controls by assessing security properties against
> +reference values defined within the policy. This assessment can be based=
 on
> +the existence of a security property (e.g., verifying if a file originat=
es
> +from initramfs) or evaluating the internal state of an immutable security
> +property. The latter includes checking the roothash of a dm-verity
> +protected device, determining whether dm-verity possesses a valid
> +signature, assessing the digest of a fs-verity protected file, or
> +determining whether fs-verity possesses a valid built-in signature. This
> +nuanced approach to policy enforcement enables a highly secure and
> +customizable system defense mechanism, tailored to specific security
> +requirements and trust models.
> +
> +To enable IPE, ensure that ``CONFIG_SECURITY_IPE`` (under
> +:menuselection:`Security -> Integrity Policy Enforcement (IPE)`) config
> +option is enabled.
> +
> +Use Cases
> +---------
> +
> +IPE works best in fixed-function devices: devices in which their purpose
> +is clearly defined and not supposed to be changed (e.g. network firewall
> +device in a data center, an IoT device, etcetera), where all software and
> +configuration is built and provisioned by the system owner.
> +
> +IPE is a long-way off for use in general-purpose computing: the Linux
> +community as a whole tends to follow a decentralized trust model (known =
as
> +the web of trust), which IPE has no support for it yet. Instead, IPE
> +supports PKI (public key infrastructure), which generally designates a
> +set of trusted entities that provide a measure of absolute trust.
> +
> +Additionally, while most packages are signed today, the files inside
> +the packages (for instance, the executables), tend to be unsigned. This
> +makes it difficult to utilize IPE in systems where a package manager is
> +expected to be functional, without major changes to the package manager
> +and ecosystem behind it.
> +
> +DIGLIM [#diglim]_ is a system that when combined with IPE, could be used=
 to
> +enable and support general-purpose computing use cases.
> +
> +Known Limitations
> +-----------------
> +
> +IPE cannot verify the integrity of anonymous executable memory, such as
> +the trampolines created by gcc closures and libffi (<3.4.2), or JIT'd co=
de.
> +Unfortunately, as this is dynamically generated code, there is no way
> +for IPE to ensure the integrity of this code to form a trust basis. In a=
ll
> +cases, the return result for these operations will be whatever the admin
> +configures as the ``DEFAULT`` action for ``EXECUTE``.
> +
> +IPE cannot verify the integrity of programs written in interpreted
> +languages when these scripts are invoked by passing these program files
> +to the interpreter. This is because the way interpreters execute these
> +files; the scripts themselves are not evaluated as executable code
> +through one of IPE's hooks, but they are merely text files that are read
> +(as opposed to compiled executables) [#interpreters]_.
> +
> +Threat Model
> +------------
> +
> +IPE specifically targets the risk of tampering with user-space executable
> +code after the kernel has initially booted, including the kernel modules
> +loaded from userspace via ``modprobe`` or ``insmod``.
> +
> +To illustrate, consider a scenario where an untrusted binary, possibly
> +malicious, is downloaded along with all necessary dependencies, includin=
g a
> +loader and libc. The primary function of IPE in this context is to preve=
nt
> +the execution of such binaries and their dependencies.
> +
> +IPE achieves this by verifying the integrity and authenticity of all
> +executable code before allowing them to run. It conducts a thorough
> +check to ensure that the code's integrity is intact and that they match =
an
> +authorized reference value (digest, signature, etc) as per the defined
> +policy. If a binary does not pass this verification process, either
> +because its integrity has been compromised or it does not meet the
> +authorization criteria, IPE will deny its execution. Additionally, IPE
> +generates audit logs which may be utilized to detect and analyze failures
> +resulting from policy violation.
> +
> +Tampering threat scenarios include modification or replacement of
> +executable code by a range of actors including:
> +
> +-  Actors with physical access to the hardware
> +-  Actors with local network access to the system
> +-  Actors with access to the deployment system
> +-  Compromised internal systems under external control
> +-  Malicious end users of the system
> +-  Compromised end users of the system
> +-  Remote (external) compromise of the system
> +
> +IPE does not mitigate threats arising from malicious but authorized
> +developers (with access to a signing certificate), or compromised
> +developer tools used by them (i.e. return-oriented programming attacks).
> +Additionally, IPE draws hard security boundary between userspace and
> +kernelspace. As a result, IPE does not provide any protections against a
> +kernel level exploit, and a kernel-level exploit can disable or tamper
> +with IPE's protections.
> +
> +Policy
> +------
> +
> +IPE policy is a plain-text [#devdoc]_ policy composed of multiple statem=
ents
> +over several lines. There is one required line, at the top of the
> +policy, indicating the policy name, and the policy version, for
> +instance::
> +
> +   policy_name=3DEx_Policy policy_version=3D0.0.0
> +
> +The policy name is a unique key identifying this policy in a human
> +readable name. This is used to create nodes under securityfs as well as
> +uniquely identify policies to deploy new policies vs update existing
> +policies.
> +
> +The policy version indicates the current version of the policy (NOT the
> +policy syntax version). This is used to prevent rollback of policy to
> +potentially insecure previous versions of the policy.
> +
> +The next portion of IPE policy are rules. Rules are formed by key=3Dvalue
> +pairs, known as properties. IPE rules require two properties: ``action``,
> +which determines what IPE does when it encounters a match against the
> +rule, and ``op``, which determines when the rule should be evaluated.
> +The ordering is significant, a rule must start with ``op``, and end with
> +``action``. Thus, a minimal rule is::
> +
> +   op=3DEXECUTE action=3DALLOW
> +
> +This example will allow any execution. Additional properties are used to
> +assess immutable security properties about the files being evaluated.
> +These properties are intended to be descriptions of systems within the
> +kernel that can provide a measure of integrity verification, such that I=
PE
> +can determine the trust of the resource based on the value of the proper=
ty.
> +
> +Rules are evaluated top-to-bottom. As a result, any revocation rules,
> +or denies should be placed early in the file to ensure that these rules
> +are evaluated before a rule with ``action=3DALLOW``.
> +
> +IPE policy supports comments. The character '#' will function as a
> +comment, ignoring all characters to the right of '#' until the newline.
> +
> +The default behavior of IPE evaluations can also be expressed in policy,
> +through the ``DEFAULT`` statement. This can be done at a global level,
> +or a per-operation level::
> +
> +   # Global
> +   DEFAULT action=3DALLOW
> +
> +   # Operation Specific
> +   DEFAULT op=3DEXECUTE action=3DALLOW
> +
> +A default must be set for all known operations in IPE. If you want to
> +preserve older policies being compatible with newer kernels that can int=
roduce
> +new operations, set a global default of ``ALLOW``, then override the
> +defaults on a per-operation basis (as above).
> +
> +With configurable policy-based LSMs, there's several issues with
> +enforcing the configurable policies at startup, around reading and
> +parsing the policy:
> +
> +1. The kernel *should* not read files from userspace, so directly reading
> +   the policy file is prohibited.
> +2. The kernel command line has a character limit, and one kernel module
> +   should not reserve the entire character limit for its own
> +   configuration.
> +3. There are various boot loaders in the kernel ecosystem, so handing
> +   off a memory block would be costly to maintain.
> +
> +As a result, IPE has addressed this problem through a concept of a "boot
> +policy". A boot policy is a minimal policy which is compiled into the
> +kernel. This policy is intended to get the system to a state where
> +userspace is set up and ready to receive commands, at which point a more
> +complex policy can be deployed via securityfs. The boot policy can be
> +specified via ``SECURITY_IPE_BOOT_POLICY`` config option, which accepts
> +a path to a plain-text version of the IPE policy to apply. This policy
> +will be compiled into the kernel. If not specified, IPE will be disabled
> +until a policy is deployed and activated through securityfs.
> +
> +Deploying Policies
> +~~~~~~~~~~~~~~~~~~
> +
> +Policies can be deployed from userspace through securityfs. These polici=
es
> +are signed through the PKCS#7 message format to enforce some level of
> +authorization of the policies (prohibiting an attacker from gaining
> +unconstrained root, and deploying an "allow all" policy). These
> +policies must be signed by a certificate that chains to the
> +``SYSTEM_TRUSTED_KEYRING``. With openssl, the policy can be signed by::
> +
> +   openssl smime -sign \
> +      -in "$MY_POLICY" \
> +      -signer "$MY_CERTIFICATE" \
> +      -inkey "$MY_PRIVATE_KEY" \
> +      -noattr \
> +      -nodetach \
> +      -nosmimecap \
> +      -outform der \
> +      -out "$MY_POLICY.p7b"
> +
> +Deploying the policies is done through securityfs, through the
> +``new_policy`` node. To deploy a policy, simply cat the file into the
> +securityfs node::
> +
> +   cat "$MY_POLICY.p7b" > /sys/kernel/security/ipe/new_policy
> +
> +Upon success, this will create one subdirectory under
> +``/sys/kernel/security/ipe/policies/``. The subdirectory will be the
> +``policy_name`` field of the policy deployed, so for the example above,
> +the directory will be ``/sys/kernel/security/ipe/policies/Ex_Policy``.
> +Within this directory, there will be seven files: ``pkcs7``, ``policy``,
> +``name``, ``version``, ``active``, ``update``, and ``delete``.
> +
> +The ``pkcs7`` file is read-only. Reading it returns the raw PKCS#7 data
> +that was provided to the kernel, representing the policy. If the policy =
being
> +read is the boot policy, this will return ``ENOENT``, as it is not signe=
d.
> +
> +The ``policy`` file is read only. Reading it returns the PKCS#7 inner
> +content of the policy, which will be the plain text policy.
> +
> +The ``active`` file is used to set a policy as the currently active poli=
cy.
> +This file is rw, and accepts a value of ``"1"`` to set the policy as act=
ive.
> +Since only a single policy can be active at one time, all other policies
> +will be marked inactive. The policy being marked active must have a poli=
cy
> +version greater or equal to the currently-running version.
> +
> +The ``update`` file is used to update a policy that is already present
> +in the kernel. This file is write-only and accepts a PKCS#7 signed
> +policy. Two checks will always be performed on this policy: First, the
> +``policy_names`` must match with the updated version and the existing
> +version. Second the updated policy must have a policy version greater th=
an
> +or equal to the currently-running version. This is to prevent rollback a=
ttacks.
> +
> +The ``delete`` file is used to remove a policy that is no longer needed.
> +This file is write-only and accepts a value of ``1`` to delete the polic=
y.
> +On deletion, the securityfs node representing the policy will be removed.
> +However, delete the current active policy is not allowed and will return
> +an operation not permitted error.
> +
> +Similarly, writing to both ``update`` and ``new_policy`` could result in
> +bad message(policy syntax error) or file exists error. The latter error =
happens
> +when trying to deploy a policy with a ``policy_name`` while the kernel a=
lready
> +has a deployed policy with the same ``policy_name``.
> +
> +Deploying a policy will *not* cause IPE to start enforcing the policy. I=
PE will
> +only enforce the policy marked active. Note that only one policy can be =
active
> +at a time.
> +
> +Once deployment is successful, the policy can be activated, by writing f=
ile
> +``/sys/kernel/security/ipe/policies/$policy_name/active``.
> +For example, the ``Ex_Policy`` can be activated by::
> +
> +   echo 1 > "/sys/kernel/security/ipe/policies/Ex_Policy/active"
> +
> +From above point on, ``Ex_Policy`` is now the enforced policy on the
> +system.
> +
> +IPE also provides a way to delete policies. This can be done via the
> +``delete`` securityfs node,
> +``/sys/kernel/security/ipe/policies/$policy_name/delete``.
> +Writing ``1`` to that file deletes the policy::
> +
> +   echo 1 > "/sys/kernel/security/ipe/policies/$policy_name/delete"
> +
> +There is only one requirement to delete a policy: the policy being delet=
ed
> +must be inactive.
> +
> +.. NOTE::
> +
> +   If a traditional MAC system is enabled (SELinux, apparmor, smack), all
> +   writes to ipe's securityfs nodes require ``CAP_MAC_ADMIN``.
> +
> +Modes
> +~~~~~
> +
> +IPE supports two modes of operation: permissive (similar to SELinux's
> +permissive mode) and enforced. In permissive mode, all events are
> +checked and policy violations are logged, but the policy is not really
> +enforced. This allows users to test policies before enforcing them.
> +
> +The default mode is enforce, and can be changed via the kernel command
> +line parameter ``ipe.enforce=3D(0|1)``, or the securityfs node
> +``/sys/kernel/security/ipe/enforce``.
> +
> +.. NOTE::
> +
> +   If a traditional MAC system is enabled (SELinux, apparmor, smack, etc=
etera),
> +   all writes to ipe's securityfs nodes require ``CAP_MAC_ADMIN``.
> +
> +Audit Events
> +~~~~~~~~~~~~
> +
> +1420 AUDIT_IPE_ACCESS
> +^^^^^^^^^^^^^^^^^^^^^
> +Event Examples::
> +
> +   type=3D1420 audit(1653364370.067:61): ipe_op=3DEXECUTE ipe_hook=3DMMA=
P enforcing=3D1 pid=3D2241 comm=3D"ld-linux.so" path=3D"/deny/lib/libc.so.6=
" dev=3D"sda2" ino=3D14549020 rule=3D"DEFAULT action=3DDENY"
> +   type=3D1300 audit(1653364370.067:61): SYSCALL arch=3Dc000003e syscall=
=3D9 success=3Dno exit=3D-13 a0=3D7f1105a28000 a1=3D195000 a2=3D5 a3=3D812 =
items=3D0 ppid=3D2219 pid=3D2241 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0=
 fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D2 comm=3D"ld-linux.=
so" exe=3D"/tmp/ipe-test/lib/ld-linux.so" subj=3Dunconfined key=3D(null)
> +   type=3D1327 audit(1653364370.067:61): 707974686F6E3300746573742F6D616=
96E2E7079002D6E00
> +
> +   type=3D1420 audit(1653364735.161:64): ipe_op=3DEXECUTE ipe_hook=3DMMA=
P enforcing=3D1 pid=3D2472 comm=3D"mmap_test" path=3D? dev=3D? ino=3D? rule=
=3D"DEFAULT action=3DDENY"
> +   type=3D1300 audit(1653364735.161:64): SYSCALL arch=3Dc000003e syscall=
=3D9 success=3Dno exit=3D-13 a0=3D0 a1=3D1000 a2=3D4 a3=3D21 items=3D0 ppid=
=3D2219 pid=3D2472 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egi=
d=3D0 sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D2 comm=3D"mmap_test" exe=3D"/root=
/overlake_test/upstream_test/vol_fsverity/bin/mmap_test" subj=3Dunconfined =
key=3D(null)
> +   type=3D1327 audit(1653364735.161:64): 707974686F6E3300746573742F6D616=
96E2E7079002D6E00
> +
> +This event indicates that IPE made an access control decision; the IPE
> +specific record (1420) is always emitted in conjunction with a
> +``AUDITSYSCALL`` record.
> +
> +Determining whether IPE is in permissive or enforced mode can be derived
> +from ``success`` property and exit code of the ``AUDITSYSCALL`` record.
> +
> +
> +Field descriptions:
> +
> ++-----------+------------+-----------+----------------------------------=
-----------------------------------------------+
> +| Field     | Value Type | Optional? | Description of Value             =
                                               |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| ipe_op    | string     | No        | The IPE operation name associated=
 with the log                                  |
> ++-----------+------------+-----------+----------------------------------=
-----------------------------------------------+
> +| ipe_hook  | string     | No        | The name of the LSM hook that tri=
ggered the IPE event                           |
> ++-----------+------------+-----------+----------------------------------=
-----------------------------------------------+
> +| enforcing | integer    | No        | The current IPE enforcing state 1=
 is in enforcing mode, 0 is in permissive mode |
> ++-----------+------------+-----------+----------------------------------=
-----------------------------------------------+
> +| pid       | integer    | No        | The pid of the process that trigg=
ered the IPE event.                            |
> ++-----------+------------+-----------+----------------------------------=
-----------------------------------------------+
> +| comm      | string     | No        | The command line program name of =
the process that triggered the IPE event       |
> ++-----------+------------+-----------+----------------------------------=
-----------------------------------------------+
> +| path      | string     | Yes       | The absolute path to the evaluate=
d file                                         |
> ++-----------+------------+-----------+----------------------------------=
-----------------------------------------------+
> +| ino       | integer    | Yes       | The inode number of the evaluated=
 file                                          |
> ++-----------+------------+-----------+----------------------------------=
-----------------------------------------------+
> +| dev       | string     | Yes       | The device name of the evaluated =
file, e.g. vda                                 |
> ++-----------+------------+-----------+----------------------------------=
-----------------------------------------------+
> +| rule      | string     | No        | The matched policy rule          =
                                               |
> ++-----------+------------+-----------+----------------------------------=
-----------------------------------------------+
> +
> +1421 AUDIT_IPE_CONFIG_CHANGE
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Event Example::
> +
> +   type=3D1421 audit(1653425583.136:54): old_active_pol_name=3D"Allow_Al=
l" old_active_pol_version=3D0.0.0 old_policy_digest=3Dsha256:E3B0C44298FC1C=
149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855 new_active_pol_name=3D"b=
oot_verified" new_active_pol_version=3D0.0.0 new_policy_digest=3Dsha256:820=
EEA5B40CA42B51F68962354BA083122A20BB846F26765076DD8EED7B8F4DB auid=3D429496=
7295 ses=3D4294967295 lsm=3Dipe res=3D1
> +   type=3D1300 audit(1653425583.136:54): SYSCALL arch=3Dc000003e syscall=
=3D1 success=3Dyes exit=3D2 a0=3D3 a1=3D5596fcae1fb0 a2=3D2 a3=3D2 items=3D=
0 ppid=3D184 pid=3D229 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 =
fsuid=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D4294967295 comm=3D"p=
ython3" exe=3D"/usr/bin/python3.10" key=3D(null)
> +   type=3D1327 audit(1653425583.136:54): PROCTITLE proctitle=3D707974686=
F6E3300746573742F6D61696E2E7079002D66002E2
> +
> +This event indicates that IPE switched the active poliy from one to anot=
her
> +along with the version and the hash digest of the two policies.
> +Note IPE can only have one policy active at a time, all access decision
> +evaluation is based on the current active policy.
> +The normal procedure to deploy a new policy is loading the policy to dep=
loy
> +into the kernel first, then switch the active policy to it.
> +
> +This record will always be emitted in conjunction with a ``AUDITSYSCALL`=
` record for the ``write`` syscall.
> +
> +Field descriptions:
> +
> ++------------------------+------------+-----------+---------------------=
------------------------------+
> +| Field                  | Value Type | Optional? | Description of Value=
                              |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+
> +| old_active_pol_name    | string     | No        | The name of previous=
 active policy                |
> ++------------------------+------------+-----------+---------------------=
------------------------------+
> +| old_active_pol_version | string     | No        | The version of previ=
ous active policy             |
> ++------------------------+------------+-----------+---------------------=
------------------------------+
> +| old_policy_digest      | string     | No        | The hash of previous=
 active policy                |
> ++------------------------+------------+-----------+---------------------=
------------------------------+
> +| new_active_pol_name    | string     | No        | The name of current =
active policy                 |
> ++------------------------+------------+-----------+---------------------=
------------------------------+
> +| new_active_pol_version | string     | No        | The version of curre=
nt active policy              |
> ++------------------------+------------+-----------+---------------------=
------------------------------+
> +| new_policy_digest      | string     | No        | The hash of current =
active policy                 |
> ++------------------------+------------+-----------+---------------------=
------------------------------+
> +| auid                   | integer    | No        | The login user ID   =
                              |
> ++------------------------+------------+-----------+---------------------=
------------------------------+
> +| ses                    | integer    | No        | The login session ID=
                              |
> ++------------------------+------------+-----------+---------------------=
------------------------------+
> +| lsm                    | string     | No        | The lsm name associa=
ted with the event            |
> ++------------------------+------------+-----------+---------------------=
------------------------------+
> +| res                    | integer    | No        | The result of the au=
dited operation(success/fail) |
> ++------------------------+------------+-----------+---------------------=
------------------------------+
> +
> +1422 AUDIT_IPE_POLICY_LOAD
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Event Example::
> +
> +   type=3D1422 audit(1653425529.927:53): policy_name=3D"boot_verified" p=
olicy_version=3D0.0.0 policy_digest=3Dsha256:820EEA5B40CA42B51F68962354BA08=
3122A20BB846F26765076DD8EED7B8F4DB auid=3D4294967295 ses=3D4294967295 lsm=
=3Dipe res=3D1
> +   type=3D1300 audit(1653425529.927:53): arch=3Dc000003e syscall=3D1 suc=
cess=3Dyes exit=3D2567 a0=3D3 a1=3D5596fcae1fb0 a2=3Da07 a3=3D2 items=3D0 p=
pid=3D184 pid=3D229 auid=3D4294967295 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsu=
id=3D0 egid=3D0 sgid=3D0 fsgid=3D0 tty=3Dpts0 ses=3D4294967295 comm=3D"pyth=
on3" exe=3D"/usr/bin/python3.10" key=3D(null)
> +   type=3D1327 audit(1653425529.927:53): PROCTITLE proctitle=3D707974686=
F6E3300746573742F6D61696E2E7079002D66002E2E
> +
> +This record indicates a new policy has been loaded into the kernel with =
the policy name, policy version and policy hash.
> +
> +This record will always be emitted in conjunction with a ``AUDITSYSCALL`=
` record for the ``write`` syscall.
> +
> +Field descriptions:
> +
> ++----------------+------------+-----------+-----------------------------=
----------------------+
> +| Field          | Value Type | Optional? | Description of Value        =
                      |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| policy_name    | string     | No        | The policy_name             =
                      |
> ++----------------+------------+-----------+-----------------------------=
----------------------+
> +| policy_version | string     | No        | The policy_version          =
                      |
> ++----------------+------------+-----------+-----------------------------=
----------------------+
> +| policy_digest  | string     | No        | The policy hash             =
                      |
> ++----------------+------------+-----------+-----------------------------=
----------------------+
> +| auid           | integer    | No        | The login user ID           =
                      |
> ++----------------+------------+-----------+-----------------------------=
----------------------+
> +| ses            | integer    | No        | The login session ID        =
                      |
> ++----------------+------------+-----------+-----------------------------=
----------------------+
> +| lsm            | string     | No        | The lsm name associated with=
 the event            |
> ++----------------+------------+-----------+-----------------------------=
----------------------+
> +| res            | integer    | No        | The result of the audited op=
eration(success/fail) |
> ++----------------+------------+-----------+-----------------------------=
----------------------+
> +
> +
> +1404 AUDIT_MAC_STATUS
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +Event Examples::
> +
> +   type=3D1404 audit(1653425689.008:55): enforcing=3D0 old_enforcing=3D1=
 auid=3D4294967295 ses=3D4294967295 enabled=3D1 old-enabled=3D1 lsm=3Dipe r=
es=3D1
> +   type=3D1300 audit(1653425689.008:55): arch=3Dc000003e syscall=3D1 suc=
cess=3Dyes exit=3D2 a0=3D1 a1=3D55c1065e5c60 a2=3D2 a3=3D0 items=3D0 ppid=
=3D405 pid=3D441 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=
=3D0 sgid=3D)
> +   type=3D1327 audit(1653425689.008:55): proctitle=3D"-bash"
> +
> +   type=3D1404 audit(1653425689.008:55): enforcing=3D1 old_enforcing=3D0=
 auid=3D4294967295 ses=3D4294967295 enabled=3D1 old-enabled=3D1 lsm=3Dipe r=
es=3D1
> +   type=3D1300 audit(1653425689.008:55): arch=3Dc000003e syscall=3D1 suc=
cess=3Dyes exit=3D2 a0=3D1 a1=3D55c1065e5c60 a2=3D2 a3=3D0 items=3D0 ppid=
=3D405 pid=3D441 auid=3D0 uid=3D0 gid=3D0 euid=3D0 suid=3D0 fsuid=3D0 egid=
=3D0 sgid=3D)
> +   type=3D1327 audit(1653425689.008:55): proctitle=3D"-bash"
> +
> +This record will always be emitted in conjunction with a ``AUDITSYSCALL`=
` record for the ``write`` syscall.
> +
> +Field descriptions:
> +
> ++---------------+------------+-----------+------------------------------=
-------------------------------------------------------------------+
> +| Field         | Value Type | Optional? | Description of Value         =
                                                                   |
> ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| enforcing     | integer    | No        | The enforcing state IPE is be=
ing switched to, 1 is in enforcing mode, 0 is in permissive mode   |
> ++---------------+------------+-----------+------------------------------=
-------------------------------------------------------------------+
> +| old_enforcing | integer    | No        | The enforcing state IPE is be=
ing switched from, 1 is in enforcing mode, 0 is in permissive mode |
> ++---------------+------------+-----------+------------------------------=
-------------------------------------------------------------------+
> +| auid          | integer    | No        | The login user ID            =
                                                                   |
> ++---------------+------------+-----------+------------------------------=
-------------------------------------------------------------------+
> +| ses           | integer    | No        | The login session ID         =
                                                                   |
> ++---------------+------------+-----------+------------------------------=
-------------------------------------------------------------------+
> +| enabled       | integer    | No        | The new TTY audit enabled set=
ting                                                               |
> ++---------------+------------+-----------+------------------------------=
-------------------------------------------------------------------+
> +| old-enabled   | integer    | No        | The old TTY audit enabled set=
ting                                                               |
> ++---------------+------------+-----------+------------------------------=
-------------------------------------------------------------------+
> +| lsm           | string     | No        | The lsm name associated with =
the event                                                          |
> ++---------------+------------+-----------+------------------------------=
-------------------------------------------------------------------+
> +| res           | integer    | No        | The result of the audited ope=
ration(success/fail)                                               |
> ++---------------+------------+-----------+------------------------------=
-------------------------------------------------------------------+
> +
> +
> +Success Auditing
> +^^^^^^^^^^^^^^^^
> +
> +IPE supports success auditing. When enabled, all events that pass IPE
> +policy and are not blocked will emit an audit event. This is disabled by
> +default, and can be enabled via the kernel command line
> +``ipe.success_audit=3D(0|1)`` or
> +``/sys/kernel/security/ipe/success_audit`` securityfs file.
> +
> +This is *very* noisy, as IPE will check every userspace binary on the
> +system, but is useful for debugging policies.
> +
> +.. NOTE::
> +
> +   If a traditional MAC system is enabled (SELinux, apparmor, smack, etc=
etera),
> +   all writes to ipe's securityfs nodes require ``CAP_MAC_ADMIN``.
> +
> +Properties
> +----------
> +
> +As explained above, IPE properties are ``key=3Dvalue`` pairs expressed i=
n IPE
> +policy. Two properties are built-into the policy parser: 'op' and 'actio=
n'.
> +The other properties are used to restrict immutable security properties
> +about the files being evaluated. Currently those properties are:
> +'``boot_verified``', '``dmverity_signature``', '``dmverity_roothash``',
> +'``fsverity_signature``', '``fsverity_digest``'. A description of all
> +properties supported by IPE are listed below:
> +
> +op
> +~~
> +
> +Indicates the operation for a rule to apply to. Must be in every rule,
> +as the first token. IPE supports the following operations:
> +
> +   ``EXECUTE``
> +
> +      Pertains to any file attempting to be executed, or loaded as an
> +      executable.
> +
> +   ``FIRMWARE``:
> +
> +      Pertains to firmware being loaded via the firmware_class interface.
> +      This covers both the preallocated buffer and the firmware file
> +      itself.
> +
> +   ``KMODULE``:
> +
> +      Pertains to loading kernel modules via ``modprobe`` or ``insmod``.
> +
> +   ``KEXEC_IMAGE``:
> +
> +      Pertains to kernel images loading via ``kexec``.
> +
> +   ``KEXEC_INITRAMFS``
> +
> +      Pertains to initrd images loading via ``kexec --initrd``.
> +
> +   ``POLICY``:
> +
> +      Controls loading policies via reading a kernel-space initiated rea=
d.
> +
> +      An example of such is loading IMA policies by writing the path
> +      to the policy file to ``$securityfs/ima/policy``
> +
> +   ``X509_CERT``:
> +
> +      Controls loading IMA certificates through the Kconfigs,
> +      ``CONFIG_IMA_X509_PATH`` and ``CONFIG_EVM_X509_PATH``.
> +
> +action
> +~~~~~~
> +
> +   Determines what IPE should do when a rule matches. Must be in every
> +   rule, as the final clause. Can be one of:
> +
> +   ``ALLOW``:
> +
> +      If the rule matches, explicitly allow access to the resource to pr=
oceed
> +      without executing any more rules.
> +
> +   ``DENY``:
> +
> +      If the rule matches, explicitly prohibit access to the resource to
> +      proceed without executing any more rules.
> +
> +boot_verified
> +~~~~~~~~~~~~~
> +
> +   This property can be utilized for authorization of files from initram=
fs.
> +   The format of this property is::
> +
> +         boot_verified=3D(TRUE|FALSE)
> +
> +
> +   .. WARNING::
> +
> +      This property will trust files from initramfs(rootfs). It should
> +      only be used during early booting stage. Before mounting the real
> +      rootfs on top of the initramfs, initramfs script will recursively
> +      remove all files and directories on the initramfs. This is typical=
ly
> +      implemented by using switch_root(8) [#switch_root]_. Therefore the
> +      initramfs will be empty and not accessible after the real
> +      rootfs takes over. It is advised to switch to a different policy
> +      that doesn't rely on the property after this point.
> +      This ensures that the trust policies remain relevant and effective
> +      throughout the system's operation.
> +
> +dmverity_roothash
> +~~~~~~~~~~~~~~~~~
> +
> +   This property can be utilized for authorization or revocation of
> +   specific dm-verity volumes, identified via its root hash. It has a
> +   dependency on the DM_VERITY module. This property is controlled by
> +   the ``IPE_PROP_DM_VERITY`` config option, it will be automatically
> +   selected when ``IPE_SECURITY`` , ``DM_VERITY`` and
> +   ``DM_VERITY_VERIFY_ROOTHASH_SIG`` are all enabled.
> +   The format of this property is::
> +
> +      dmverity_roothash=3DDigestName:HexadecimalString
> +
> +   The supported DigestNames for dmverity_roothash are [#dmveritydigests=
]_ [#securedigest]_ :
> +
> +      + blake2b-512
> +      + blake2s-256
> +      + sha1
> +      + sha256
> +      + sha384
> +      + sha512
> +      + sha3-224
> +      + sha3-256
> +      + sha3-384
> +      + sha3-512
> +      + md4
> +      + md5
> +      + sm3
> +      + rmd160
> +
> +dmverity_signature
> +~~~~~~~~~~~~~~~~~~
> +
> +   This property can be utilized for authorization of all dm-verity
> +   volumes that have a signed roothash that validated by a keyring
> +   specified by dm-verity's configuration, either the system trusted
> +   keyring, or the secondary keyring. It depends on
> +   ``DM_VERITY_VERIFY_ROOTHASH_SIG`` config option and is controlled by
> +   the ``IPE_PROP_DM_VERITY`` config option, it will be automatically
> +   selected when ``IPE_SECURITY``, ``DM_VERITY`` and
> +   ``DM_VERITY_VERIFY_ROOTHASH_SIG`` are all enabled.
> +   The format of this property is::
> +
> +      dmverity_signature=3D(TRUE|FALSE)
> +
> +fsverity_digest
> +~~~~~~~~~~~~~~~
> +
> +   This property can be utilized for authorization or revocation of
> +   specific fsverity enabled file, identified via its fsverity digest.
> +   It depends on ``FS_VERITY`` config option and is controlled by
> +   ``CONFIG_IPE_PROP_FS_VERITY``. The format of this property is::
> +
> +      fsverity_digest=3DDigestName:HexadecimalString
> +
> +   The supported DigestNames for fsverity_roothash are [#fsveritydigest]=
_ [#securedigest]_ :
> +
> +      + sha256
> +      + sha512
> +
> +fsverity_signature
> +~~~~~~~~~~~~~~~~~~
> +
> +   This property is used to authorize all fs-verity enabled files that h=
ave
> +   been verified by fs-verity's built-in signature mechanism. The signat=
ure
> +   verification relies on a key stored within the ".fs-verity" keyring. =
It
> +   depends on ``CONFIG_FS_VERITY_BUILTIN_SIGNATURES`` and  it is control=
led by
> +   the Kconfig ``CONFIG_IPE_PROP_FS_VERITY``. The format of this
> +   property is::
> +
> +      fsverity_signature=3D(TRUE|FALSE)
> +
> +Policy Examples
> +---------------
> +
> +Allow all
> +~~~~~~~~~
> +
> +::
> +
> +   policy_name=3DAllow_All policy_version=3D0.0.0
> +   DEFAULT action=3DALLOW
> +
> +Allow only initramfs
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   policy_name=3DAllow_All_Initramfs policy_version=3D0.0.0
> +   DEFAULT action=3DDENY
> +
> +   op=3DEXECUTE boot_verified=3DTRUE action=3DALLOW
> +
> +Allow any signed dm-verity volume and the initramfs
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   policy_name=3DAllowSignedAndInitramfs policy_version=3D0.0.0
> +   DEFAULT action=3DDENY
> +
> +   op=3DEXECUTE boot_verified=3DTRUE action=3DALLOW
> +   op=3DEXECUTE dmverity_signature=3DTRUE action=3DALLOW
> +
> +Prohibit execution from a specific dm-verity volume
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   policy_name=3DAllowSignedAndInitramfs policy_version=3D0.0.0
> +   DEFAULT action=3DDENY
> +
> +   op=3DEXECUTE dmverity_roothash=3Dsha256:cd2c5bae7c6c579edaae4353049d5=
8eb5f2e8be0244bf05345bc8e5ed257baff action=3DDENY
> +
> +   op=3DEXECUTE boot_verified=3DTRUE action=3DALLOW
> +   op=3DEXECUTE dmverity_signature=3DTRUE action=3DALLOW
> +
> +Allow only a specific dm-verity volume
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   policy_name=3DAllowSignedAndInitramfs policy_version=3D0.0.0
> +   DEFAULT action=3DDENY
> +
> +   op=3DEXECUTE dmverity_roothash=3Dsha256:401fcec5944823ae12f62726e8184=
407a5fa9599783f030dec146938 action=3DALLOW
> +
> +Allow any signed fs-verity file
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   policy_name=3DAllowSignedFSVerity policy_version=3D0.0.0
> +   DEFAULT action=3DDENY
> +
> +   op=3DEXECUTE fsverity_signature=3DTRUE action=3DALLOW
> +
> +Prohibit execution of a specific fs-verity file
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +   policy_name=3DProhibitSpecificFSVF policy_version=3D0.0.0
> +   DEFAULT action=3DDENY
> +
> +   op=3DEXECUTE fsverity_digest=3Dsha256:fd88f2b8824e197f850bf4c5109bea5=
cf0ee38104f710843bb72da796ba5af9e action=3DDENY
> +   op=3DEXECUTE boot_verified=3DTRUE action=3DALLOW
> +   op=3DEXECUTE dmverity_signature=3DTRUE action=3DALLOW
> +
> +Additional Information
> +----------------------
> +
> +- `Github Repository <https://github.com/microsoft/ipe>`_
> +- Documentation/security/ipe.rst
> +
> +FAQ
> +---
> +
> +Q:
> +   What's the difference between other LSMs which provide a measure of
> +   trust-based access control?
> +
> +A:
> +
> +   In general, there's two other LSMs that can provide similar functiona=
lity:
> +   IMA, and Loadpin.
> +
> +   IMA and IPE are functionally very similar. The significant difference=
 between
> +   the two is the policy. [#devdoc]_
> +
> +   Loadpin and IPE differ fairly dramatically, as Loadpin only covers th=
e IPE's
> +   kernel read operations, whereas IPE is capable of controlling executi=
on
> +   on top of kernel read. The trust model is also different; Loadpin roo=
ts its
> +   trust in the initial super-block, whereas trust in IPE is stemmed fro=
m kernel
> +   itself (via ``SYSTEM_TRUSTED_KEYS``).
> +
> +-----------
> +
> +.. [#diglim] https://lore.kernel.org/bpf/4d6932e96d774227b42721d9f645ba5=
1@huawei.com/T/
> +
> +.. [#interpreters] There is `some interest in solving this issue <https:=
//lore.kernel.org/lkml/20220321161557.495388-1-mic@digikod.net/>`_.
> +
> +.. [#devdoc] Please see Documentation/security/ipe.rst for more on this =
topic.
> +
> +.. [#switch_root] https://man7.org/linux/man-pages/man8/switch_root.8.ht=
ml
> +
> +.. [#fsveritydigest] These hash algorithms are based on values accepted =
by fsverity-utils;
> +                     IPE does not impose any restrictions on the digest =
algorithm itself;
> +                     thus, this list may be out of date.
> +
> +.. [#dmveritydigests] These hash algorithms are based on values accepted=
 by dm-verity,
> +                      specifically ``crypto_alloc_ahash`` in ``verity_ct=
r``; ``veritysetup``
> +                      does support more algorithms than the list above. =
IPE does not impose
> +                      any restrictions on the digest algorithm itself; t=
hus, this list
> +                      may be out of date.
> +
> +.. [#securedigest] Please ensure you are using cryptographically secure =
hash functions;
> +                   just because something is *supported* does not mean i=
t is *secure*.
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 70046a019d42..7b7a24a59747 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2321,6 +2321,18 @@
>  	ipcmni_extend	[KNL,EARLY] Extend the maximum number of unique System V
>  			IPC identifiers from 32,768 to 16,777,216.
> =20
> +	ipe.enforce=3D	[IPE]
> +			Format: <bool>
> +			Determine whether IPE starts in permissive (0) or
> +			enforce (1) mode. The default is enforce.
> +
> +	ipe.success_audit=3D
> +			[IPE]
> +			Format: <bool>
> +			Start IPE with success auditing enabled, emitting
> +			an audit event when a binary is allowed. The default
> +			is 0.
> +
>  	irqaffinity=3D	[SMP] Set the default irq affinity mask
>  			The argument is a cpu list, as described above.
> =20
> diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/files=
ystems/fsverity.rst
> index 362b7a5dc300..46ab280e1b13 100644
> --- a/Documentation/filesystems/fsverity.rst
> +++ b/Documentation/filesystems/fsverity.rst
> @@ -92,7 +92,9 @@ authenticating fs-verity file hashes include:
>    "IPE policy" specifically allows for the authorization of fs-verity
>    files using properties ``fsverity_digest`` for identifying
>    files by their verity digest, and ``fsverity_signature`` to authorize
> -  files with a verified fs-verity's built-in signature.
> +  files with a verified fs-verity's built-in signature. For
> +  details on configuring IPE policies and understanding its operational
> +  modes, please refer to Documentation/admin-guide/LSM/ipe.rst.
> =20
>  - Trusted userspace code in combination with `Built-in signature
>    verification`_.  This approach should be used only with great care.
> @@ -508,6 +510,7 @@ be carefully considered before using them:
>    files with a verified fs-verity builtin signature to perform certain
>    operations, such as execution. Note that IPE doesn't require
>    fs.verity.require_signatures=3D1.
> +  Please refer to Documentation/admin-guide/LSM/ipe.rst for more details.
> =20
>  - A file's builtin signature can only be set at the same time that
>    fs-verity is being enabled on the file.  Changing or deleting the
> diff --git a/Documentation/security/index.rst b/Documentation/security/in=
dex.rst
> index 59f8fc106cb0..3e0a7114a862 100644
> --- a/Documentation/security/index.rst
> +++ b/Documentation/security/index.rst
> @@ -19,3 +19,4 @@ Security Documentation
>     digsig
>     landlock
>     secrets/index
> +   ipe
> diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.=
rst
> new file mode 100644
> index 000000000000..674827982a72
> --- /dev/null
> +++ b/Documentation/security/ipe.rst
> @@ -0,0 +1,444 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Integrity Policy Enforcement (IPE) - Kernel Documentation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. NOTE::
> +
> +   This is documentation targeted at developers, instead of administrato=
rs.
> +   If you're looking for documentation on the usage of IPE, please see
> +   Documentation/admin-guide/LSM/ipe.rst
> +
> +Historical Motivation
> +---------------------
> +
> +The original issue that prompted IPE's implementation was the creation
> +of a locked-down system. This system would be born-secure, and have
> +strong integrity guarantees over both the executable code, and specific
> +*data files* on the system, that were critical to its function. These
> +specific data files would not be readable unless they passed integrity
> +policy. A mandatory access control system would be present, and
> +as a result, xattrs would have to be protected. This lead to a selection
> +of what would provide the integrity claims. At the time, there were two
> +main mechanisms considered that could guarantee integrity for the system
> +with these requirements:
> +
> +  1. IMA + EVM Signatures
> +  2. DM-Verity
> +
> +Both options were carefully considered, however the choice to use DM-Ver=
ity
> +over IMA+EVM as the *integrity mechanism* in the original use case of IPE
> +was due to three main reasons:
> +
> +  1. Protection of additional attack vectors:
> +
> +    * With IMA+EVM, without an encryption solution, the system is vulner=
able
> +      to offline attack against the aforementioned specific data files.
> +
> +      Unlike executables, read operations (like those on the protected d=
ata
> +      files), cannot be enforced to be globally integrity verified. This=
 means
> +      there must be some form of selector to determine whether a read sh=
ould
> +      enforce the integrity policy, or it should not.
> +
> +      At the time, this was done with mandatory access control labels. A=
n IMA
> +      policy would indicate what labels required integrity verification,=
 which
> +      presented an issue: EVM would protect the label, but if an attacke=
r could
> +      modify filesystem offline, the attacker could wipe all the xattrs -
> +      including the SELinux labels that would be used to determine wheth=
er the
> +      file should be subject to integrity policy.
> +
> +      With DM-Verity, as the xattrs are saved as part of the Merkel tree=
, if
> +      offline mount occurs against the filesystem protected by dm-verity=
, the
> +      checksum no longer matches and the file fails to be read.
> +
> +    * As userspace binaries are paged in Linux, dm-verity also offers the
> +      additional protection against a hostile block device. In such an a=
ttack,
> +      the block device reports the appropriate content for the IMA hash
> +      initially, passing the required integrity check. Then, on the page=
 fault
> +      that accesses the real data, will report the attacker's payload. S=
ince
> +      dm-verity will check the data when the page fault occurs (and the =
disk
> +      access), this attack is mitigated.
> +
> +  2. Performance:
> +
> +    * dm-verity provides integrity verification on demand as blocks are
> +      read versus requiring the entire file being read into memory for
> +      validation.
> +
> +  3. Simplicity of signing:
> +
> +    * No need for two signatures (IMA, then EVM): one signature covers
> +      an entire block device.
> +    * Signatures can be stored externally to the filesystem metadata.
> +    * The signature supports an x.509-based signing infrastructure.
> +
> +The next step was to choose a *policy* to enforce the integrity mechanis=
m.
> +The minimum requirements for the policy were:
> +
> +  1. The policy itself must be integrity verified (preventing trivial
> +     attack against it).
> +  2. The policy itself must be resistant to rollback attacks.
> +  3. The policy enforcement must have a permissive-like mode.
> +  4. The policy must be able to be updated, in its entirety, without
> +     a reboot.
> +  5. Policy updates must be atomic.
> +  6. The policy must support *revocations* of previously authored
> +     components.
> +  7. The policy must be auditable, at any point-of-time.
> +
> +IMA, as the only integrity policy mechanism at the time, was
> +considered against these list of requirements, and did not fulfill
> +all of the minimum requirements. Extending IMA to cover these
> +requirements was considered, but ultimately discarded for a
> +two reasons:
> +
> +  1. Regression risk; many of these changes would result in
> +     dramatic code changes to IMA, which is already present in the
> +     kernel, and therefore might impact users.
> +
> +  2. IMA was used in the system for measurement and attestation;
> +     separation of measurement policy from local integrity policy
> +     enforcement was considered favorable.
> +
> +Due to these reasons, it was decided that a new LSM should be created,
> +whose responsibility would be only the local integrity policy enforcemen=
t.
> +
> +Role and Scope
> +--------------
> +
> +IPE, as its name implies, is fundamentally an integrity policy enforceme=
nt
> +solution; IPE does not mandate how integrity is provided, but instead
> +leaves that decision to the system administrator to set the security bar,
> +via the mechanisms that they select that suit their individual needs.
> +There are several different integrity solutions that provide a different
> +level of security guarantees; and IPE allows sysadmins to express policy=
 for
> +theoretically all of them.
> +
> +IPE does not have an inherent mechanism to ensure integrity on its own.
> +Instead, there are more effective layers available for building systems =
that
> +can guarantee integrity. It's important to note that the mechanism for p=
roving
> +integrity is independent of the policy for enforcing that integrity clai=
m.
> +
> +Therefore, IPE was designed around:
> +
> +  1. Easy integrations with integrity providers.
> +  2. Ease of use for platform administrators/sysadmins.
> +
> +Design Rationale:
> +-----------------
> +
> +IPE was designed after evaluating existing integrity policy solutions
> +in other operating systems and environments. In this survey of other
> +implementations, there were a few pitfalls identified:
> +
> +  1. Policies were not readable by humans, usually requiring a binary
> +     intermediary format.
> +  2. A single, non-customizable action was implicitly taken as a default.
> +  3. Debugging the policy required manual steps to determine what rule w=
as violated.
> +  4. Authoring a policy required an in-depth knowledge of the larger sys=
tem,
> +     or operating system.
> +
> +IPE attempts to avoid all of these pitfalls.
> +
> +Policy
> +~~~~~~
> +
> +Plain Text
> +^^^^^^^^^^
> +
> +IPE's policy is plain-text. This introduces slightly larger policy files=
 than
> +other LSMs, but solves two major problems that occurs with some integrit=
y policy
> +solutions on other platforms.
> +
> +The first issue is one of code maintenance and duplication. To author po=
licies,
> +the policy has to be some form of string representation (be it structure=
d,
> +through XML, JSON, YAML, etcetera), to allow the policy author to unders=
tand
> +what is being written. In a hypothetical binary policy design, a seriali=
zer
> +is necessary to write the policy from the human readable form, to the bi=
nary
> +form, and a deserializer is needed to interpret the binary form into a d=
ata
> +structure in the kernel.
> +
> +Eventually, another deserializer will be needed to transform the binary =
=66rom
> +back into the human-readable form with as much information preserved. Th=
is is because a
> +user of this access control system will have to keep a lookup table of a=
 checksum
> +and the original file itself to try to understand what policies have bee=
n deployed
> +on this system and what policies have not. For a single user, this may b=
e alright,
> +as old policies can be discarded almost immediately after the update tak=
es hold.
> +For users that manage computer fleets in the thousands, if not hundreds =
of thousands,
> +with multiple different operating systems, and multiple different operat=
ional needs,
> +this quickly becomes an issue, as stale policies from years ago may be p=
resent,
> +quickly resulting in the need to recover the policy or fund extensive in=
frastructure
> +to track what each policy contains.
> +
> +With now three separate serializer/deserializers, maintenance becomes co=
stly. If the
> +policy avoids the binary format, there is only one required serializer: =
=66rom the
> +human-readable form to the data structure in kernel, saving on code main=
tenance,
> +and retaining operability.
> +
> +The second issue with a binary format is one of transparency. As IPE con=
trols
> +access based on the trust of the system's resources, it's policy must al=
so be
> +trusted to be changed. This is done through signatures, resulting in nee=
ding
> +signing as a process. Signing, as a process, is typically done with a
> +high security bar, as anything signed can be used to attack integrity
> +enforcement systems. It is also important that, when signing something, =
that
> +the signer is aware of what they are signing. A binary policy can cause
> +obfuscation of that fact; what signers see is an opaque binary blob. A
> +plain-text policy, on the other hand, the signers see the actual policy
> +submitted for signing.
> +
> +Boot Policy
> +~~~~~~~~~~~
> +
> +IPE, if configured appropriately, is able to enforce a policy as soon as=
 a
> +kernel is booted and usermode starts. That implies some level of storage
> +of the policy to apply the minute usermode starts. Generally, that stora=
ge
> +can be handled in one of three ways:
> +
> +  1. The policy file(s) live on disk and the kernel loads the policy pri=
or
> +     to an code path that would result in an enforcement decision.
> +  2. The policy file(s) are passed by the bootloader to the kernel, who
> +     parses the policy.
> +  3. There is a policy file that is compiled into the kernel that is
> +     parsed and enforced on initialization.
> +
> +The first option has problems: the kernel reading files from userspace
> +is typically discouraged and very uncommon in the kernel.
> +
> +The second option also has problems: Linux supports a variety of bootloa=
ders
> +across its entire ecosystem - every bootloader would have to support this
> +new methodology or there must be an independent source. It would likely
> +result in more drastic changes to the kernel startup than necessary.
> +
> +The third option is the best but it's important to be aware that the pol=
icy
> +will take disk space against the kernel it's compiled in. It's important=
 to
> +keep this policy generalized enough that userspace can load a new, more
> +complicated policy, but restrictive enough that it will not overauthorize
> +and cause security issues.
> +
> +The initramfs provides a way that this bootup path can be established. T=
he
> +kernel starts with a minimal policy, that trusts the initramfs only. Ins=
ide
> +the initramfs, when the real rootfs is mounted, but not yet transferred =
to,
> +it deploys and activates a policy that trusts the new root filesystem.
> +This prevents overauthorization at any step, and keeps the kernel policy
> +to a minimal size.
> +
> +Startup
> +^^^^^^^
> +
> +Not every system, however starts with an initramfs, so the startup policy
> +compiled into the kernel will need some flexibility to express how trust
> +is established for the next phase of the bootup. To this end, if we just
> +make the compiled-in policy a full IPE policy, it allows system builders
> +to express the first stage bootup requirements appropriately.
> +
> +Updatable, Rebootless Policy
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +As requirements change over time (vulnerabilities are found in previously
> +trusted applications, keys roll, etcetera). Updating a kernel to change =
the
> +meet those security goals is not always a suitable option, as updates ar=
e not
> +always risk-free, and blocking a security update leaves systems vulnerab=
le.
> +This means IPE requires a policy that can be completely updated (allowing
> +revocations of existing policy) from a source external to the kernel (al=
lowing
> +policies to be updated without updating the kernel).
> +
> +Additionally, since the kernel is stateless between invocations, and rea=
ding
> +policy files off the disk from kernel space is a bad idea(tm), then the
> +policy updates have to be done rebootlessly.
> +
> +To allow an update from an external source, it could be potentially mali=
cious,
> +so this policy needs to have a way to be identified as trusted. This is
> +done via a signature chained to a trust source in the kernel. Arbitraril=
y,
> +this is  the ``SYSTEM_TRUSTED_KEYRING``, a keyring that is initially
> +populated at kernel compile-time, as this matches the expectation that t=
he
> +author of the compiled-in policy described above is the same entity that=
 can
> +deploy policy updates.
> +
> +Anti-Rollback / Anti-Replay
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Over time, vulnerabilities are found and trusted resources may not be
> +trusted anymore. IPE's policy has no exception to this. There can be
> +instances where a mistaken policy author deploys an insecure policy,
> +before correcting it with a secure policy.
> +
> +Assuming that as soon as the insecure policy is signed, and an attacker
> +acquires the insecure policy, IPE needs a way to prevent rollback
> +from the secure policy update to the insecure policy update.
> +
> +Initially, IPE's policy can have a policy_version that states the
> +minimum required version across all policies that can be active on
> +the system. This will prevent rollback while the system is live.
> +
> +.. WARNING::
> +
> +  However, since the kernel is stateless across boots, this policy
> +  version will be reset to 0.0.0 on the next boot. System builders
> +  need to be aware of this, and ensure the new secure policies are
> +  deployed ASAP after a boot to ensure that the window of
> +  opportunity is minimal for an attacker to deploy the insecure policy.
> +
> +Implicit Actions:
> +~~~~~~~~~~~~~~~~~
> +
> +The issue of implicit actions only becomes visible when you consider
> +a mixed level of security bars across multiple operations in a system.
> +For example, consider a system that has strong integrity guarantees
> +over both the executable code, and specific *data files* on the system,
> +that were critical to its function. In this system, three types of polic=
ies
> +are possible:
> +
> +  1. A policy in which failure to match any rules in the policy results
> +     in the action being denied.
> +  2. A policy in which failure to match any rules in the policy results
> +     in the action being allowed.
> +  3. A policy in which the action taken when no rules are matched is
> +     specified by the policy author.
> +
> +The first option could make a policy like this::
> +
> +  op=3DEXECUTE integrity_verified=3DYES action=3DALLOW
> +
> +In the example system, this works well for the executables, as all
> +executables should have integrity guarantees, without exception. The
> +issue becomes with the second requirement about specific data files.
> +This would result in a policy like this (assuming each line is
> +evaluated in order)::
> +
> +  op=3DEXECUTE integrity_verified=3DYES action=3DALLOW
> +
> +  op=3DREAD integrity_verified=3DNO label=3Dcritical_t action=3DDENY
> +  op=3DREAD action=3DALLOW
> +
> +This is somewhat clear if you read the docs, understand the policy
> +is executed in order and that the default is a denial; however, the
> +last line effectively changes that default to an ALLOW. This is
> +required, because in a realistic system, there are some unverified
> +reads (imagine appending to a log file).
> +
> +The second option, matching no rules results in an allow, is clearer
> +for the specific data files::
> +
> +  op=3DREAD integrity_verified=3DNO label=3Dcritical_t action=3DDENY
> +
> +And, like the first option, falls short with the opposite scenario,
> +effectively needing to override the default::
> +
> +  op=3DEXECUTE integrity_verified=3DYES action=3DALLOW
> +  op=3DEXECUTE action=3DDENY
> +
> +  op=3DREAD integrity_verified=3DNO label=3Dcritical_t action=3DDENY
> +
> +This leaves the third option. Instead of making users be clever
> +and override the default with an empty rule, force the end-user
> +to consider what the appropriate default should be for their
> +scenario and explicitly state it::
> +
> +  DEFAULT op=3DEXECUTE action=3DDENY
> +  op=3DEXECUTE integrity_verified=3DYES action=3DALLOW
> +
> +  DEFAULT op=3DREAD action=3DALLOW
> +  op=3DREAD integrity_verified=3DNO label=3Dcritical_t action=3DDENY
> +
> +Policy Debugging:
> +~~~~~~~~~~~~~~~~~
> +
> +When developing a policy, it is useful to know what line of the policy
> +is being violated to reduce debugging costs; narrowing the scope of the
> +investigation to the exact line that resulted in the action. Some integr=
ity
> +policy systems do not provide this information, instead providing the
> +information that was used in the evaluation. This then requires a correl=
ation
> +with the policy to evaluate what went wrong.
> +
> +Instead, IPE just emits the rule that was matched. This limits the scope
> +of the investigation to the exact policy line (in the case of a specific
> +rule), or the section (in the case of a DEFAULT). This decreases iterati=
on
> +and investigation times when policy failures are observed while evaluati=
ng
> +policies.
> +
> +IPE's policy engine is also designed in a way that it makes it obvious to
> +a human of how to investigate a policy failure. Each line is evaluated in
> +the sequence that is written, so the algorithm is very simple to follow
> +for humans to recreate the steps and could have caused the failure. In o=
ther
> +surveyed systems, optimizations occur (sorting rules, for instance) when=
 loading
> +the policy. In those systems, it requires multiple steps to debug, and t=
he
> +algorithm may not always be clear to the end-user without reading the co=
de first.
> +
> +Simplified Policy:
> +~~~~~~~~~~~~~~~~~~
> +
> +Finally, IPE's policy is designed for sysadmins, not kernel developers. =
Instead
> +of covering individual LSM hooks (or syscalls), IPE covers operations. T=
his means
> +instead of sysadmins needing to know that the syscalls ``mmap``, ``mprot=
ect``,
> +``execve``, and ``uselib`` must have rules protecting them, they must si=
mple know
> +that they want to restrict code execution. This limits the amount of byp=
asses that
> +could occur due to a lack of knowledge of the underlying system; whereas=
 the
> +maintainers of IPE, being kernel developers can make the correct choice =
to determine
> +whether something maps to these operations, and under what conditions.
> +
> +Implementation Notes
> +--------------------
> +
> +Anonymous Memory
> +~~~~~~~~~~~~~~~~
> +
> +Anonymous memory isn't treated any differently from any other access in =
IPE.
> +When anonymous memory is mapped with ``+X``, it still comes into the ``f=
ile_mmap``
> +or ``file_mprotect`` hook, but with a ``NULL`` file object. This is subm=
itted to
> +the evaluation, like any other file, however, all current trust mechanis=
ms will
> +return false as there is nothing to evaluate. This means anonymous memory
> +execution is subject to whatever the ``DEFAULT`` is for ``EXECUTE``.
> +
> +.. WARNING::
> +
> +  This also occurs with the ``kernel_load_data`` hook, which is used by =
signed
> +  and compressed kernel modules. Using signed and compressed kernel modu=
les with
> +  IPE will always result in the ``DEFAULT`` action for ``KMODULE``.
> +
> +Securityfs Interface
> +~~~~~~~~~~~~~~~~~~~~
> +
> +The per-policy securityfs tree is somewhat unique. For example, for
> +a standard securityfs policy tree::
> +
> +  MyPolicy
> +    |- active
> +    |- delete
> +    |- name
> +    |- pkcs7
> +    |- policy
> +    |- update
> +    |- version
> +
> +The policy is stored in the ``->i_private`` data of the MyPolicy inode.
> +
> +Tests
> +-----
> +
> +IPE has KUnit Tests for the policy parser. Recommended kunitconfig::
> +
> +  CONFIG_KUNIT=3Dy
> +  CONFIG_SECURITY=3Dy
> +  CONFIG_SECURITYFS=3Dy
> +  CONFIG_PKCS7_MESSAGE_PARSER=3Dy
> +  CONFIG_SYSTEM_DATA_VERIFICATION=3Dy
> +  CONFIG_FS_VERITY=3Dy
> +  CONFIG_FS_VERITY_BUILTIN_SIGNATURES=3Dy
> +  CONFIG_BLOCK=3Dy
> +  CONFIG_MD=3Dy
> +  CONFIG_BLK_DEV_DM=3Dy
> +  CONFIG_DM_VERITY=3Dy
> +  CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=3Dy
> +  CONFIG_NET=3Dy
> +  CONFIG_AUDIT=3Dy
> +  CONFIG_AUDITSYSCALL=3Dy
> +  CONFIG_BLK_DEV_INITRD=3Dy
> +
> +  CONFIG_SECURITY_IPE=3Dy
> +  CONFIG_IPE_PROP_DM_VERITY=3Dy
> +  CONFIG_IPE_PROP_FS_VERITY=3Dy
> +  CONFIG_SECURITY_IPE_KUNIT_TEST=3Dy
> +
> +In addition, IPE has a python based integration
> +`test suite <https://github.com/microsoft/ipe/tree/test-suite>`_ that
> +can test both user interfaces and enforcement functionalities.

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--skOkNqw6jHEQ6Ykp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh0ZgwAKCRD2uYlJVVFO
oxurAP9qjQxone32Ri18ky0+Y7/Wvb+vjTOABP/8WO5y/eZBFgD/e1VWqenvqZ9L
T5G4oE79IXR0nOh8siBHv9RtPAWNeQA=
=htm0
-----END PGP SIGNATURE-----

--skOkNqw6jHEQ6Ykp--

