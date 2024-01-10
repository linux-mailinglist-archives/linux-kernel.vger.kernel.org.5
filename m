Return-Path: <linux-kernel+bounces-22583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F62A82A005
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE69283FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5BE4D588;
	Wed, 10 Jan 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvvFlzaF"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00614D580
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd1a1c5addso51798751fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704909771; x=1705514571; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdVGwDqFF5WhKMEdlXyQJIQK1oV9LpsDsaPiNywuwAw=;
        b=LvvFlzaFwXYduecPy53Kzq9YbUj10cWCAHFOBoVJzVKLeGOtvIyBWut3c/SXPOQDyF
         JpkqqP2HyKl5q+62BlBnwPtmWjbQJMK1LpJr3avU7dQOaZejXbzJGF9yzCNZSw2V/nSv
         vvb57m4sV/r+xYhFC8TDLinUy0rw0KuB3kLigWRS8O+g2/rWGJ37UQ8m3ybiAISnX5tY
         EEXC3ysMBvS+UIooRJqOijlY8nDJD5+czFk9p/TJC/t6ZacrngEmzzHYbBwaraqVR6Kx
         Ic3i3GdONxbPWcheXWRPn1u9Q0Cu/f568K2Okv4EVFTOYbcVHR4iuVCzPJNZ8gX3If25
         YUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909771; x=1705514571;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdVGwDqFF5WhKMEdlXyQJIQK1oV9LpsDsaPiNywuwAw=;
        b=sbXbP24ehbtkQeJmiwiPkdbNMMhQ1WJbCTaJiBaMtNdWcj7iylfKQjaEsWJkuscaww
         jQMmCgmJBsequfDxngSCLTW0T21iHF7RjBZ6lDMe0gDAUzH55Sb79HxsY7H5ksKRg7K5
         /vKE4c9s896NCrvSQeEZcaPlRXIMAudc9NH/q5Pqp8wwfRIxXdzD5Prow/DIZmAz5cYx
         OFWpdy+fwywzU4enPJVWXea0O18xZOeBw/MUhx4+qznwFUXPq+tEM6XwkAWUPFWCjMTM
         Oh569jm8HJnMVsASbOOQ9G0ebk6gec7W5CsM8+Kz15pjj2gpF7id3BySsbpra0P5s36n
         G2pQ==
X-Gm-Message-State: AOJu0Yz4eZjflqkcmcEOKfhtOvx3alPhfAOd665ArHpa5a2bjFczpCwd
	3Wn8gLINquG/BEtVysDJaQ==
X-Google-Smtp-Source: AGHT+IHtUiCLWYxMrpPG3P8LBi+6SJ90gMdT8TUhNRgBrRz49DgkN6Ye2tKn5sOQ9F057AmsYPCgMw==
X-Received: by 2002:a2e:9f08:0:b0:2cd:307b:5bd1 with SMTP id u8-20020a2e9f08000000b002cd307b5bd1mr721453ljk.68.1704909770269;
        Wed, 10 Jan 2024 10:02:50 -0800 (PST)
Received: from p183 ([46.53.248.125])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402069300b005551387bb85sm2196172edy.94.2024.01.10.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:02:49 -0800 (PST)
Date: Wed, 10 Jan 2024 21:02:48 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	pinskia@gmail.com
Subject: Linux++ 2024 (was Re: [PATCH 00/45] C++: Convert the kernel to C++)
Message-ID: <7e72d2eb-0013-4289-9714-cf2dd0bf0076@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

hpa wrote:

> and C++ has in fact, in my personal opinion, finally "grown up" to be a better C for 
> the kind of embedded programming that an OS kernel epitomizes.

whoo-hoo, calm down, sir... :^)


I have working Linux++ patchset since Linux 5.3. It is one specific
trimmed down .config compiled with g++, booting old x86_64 Debian VM
which can survive LTP under KASAN and some other debugging options.
It has IPv4 networking, it's good enough.

Below is my experience "maintaining" it:
-----------------------------------------------------------------------
* keywords

Some identifiers have been promoted to keywords. There is no way around
it other than -fno-operator-names which covers negligible amount of
instance of macro arguments.

Inline assembly also requires some renaming: asm("%[new]") doesn't work.

Solution: bulk rename

	private		=>	priv	(delete some unused members)
	virtual		=>	virt
	this		=>	nb	(for "struct notifier_block*")
	register	=>	delete for non-asm variables

	keyword		=>	keyword_	(for everything else)

This includes "struct class", "new", etc. There is no point in making up
new names because it is boring part of the exercise.

Some keywords happen to hide in unused prototypes, delete those altogether.
-----------------------------------------------------------------------
* enum forward declarations

"enum E;" doesn't work!

Forward declaring enums with explicit underlying type works:

	-enum nf_nat_manip_type;
	+enum nf_nat_manip_type:unsigned int;

	-enum nf_nat_manip_type {
	+enum nf_nat_manip_type:unsigned int {

Everything must be kept in sync obviously.
-----------------------------------------------------------------------
* "extern asmlinkage"

"extern asmlinkage" expands to 'extern extern "C"' which doesn't work.

Solution: delete "extern" (which should be removed from all prototypes anyway).
-----------------------------------------------------------------------
* void* and casts in general

** implicit void* to T* cast

Most of them had to be added. It will upset a lot of people deleting
them for decades. Ideally g++ gives up new command line option.

The way to reduce cast problem is to notice that
a) some "char*" can be "void*"

	kernel compiles with -Wno-pointer-arith legitimising "void* + int"

	 static inline void copy_user_highpage(struct page *to, struct page *from,
	 {
	-	char *vfrom, *vto;
	+	void *vfrom, *vto;
	 
	 	vfrom = kmap_local_page(from);
	 	vto = kmap_local_page(to);

b) _probably_ templated kmalloc (PROBABLY)

	template<typename T>
	inline
	T*
	lalloc(gfp_t)
	{
		...
	}

	struct S* obj = lalloc<S>(GFP_KERNEL);
	struct S* obj = lzalloc2<S>(GFP_KERNEL, n1);

This will reduce casts but it won't reduce churn: line containing
kmalloc must be changed anyhow.

c) some "char*" should be "const char*"
	change as usual

	 struct pci_reset_fn_method {
	 	int (*reset_fn)(struct pci_dev *pdev, bool probe);
	-	char *name;
	+	const char *name;
	 };

d) ERR_PTR and ERR_CAST can be tamed to a degree:

	+class ERR_PTR {
	+	long e;
	+
	+public:
	+	[[nodiscard]]
	+	constexpr explicit
	+	ERR_PTR(long e)
	+		: e{e}
	+	{
	+	}
	+
	+	template<typename T>
	+	[[nodiscard]]
	+	constexpr
	+	operator T*() const
	+	{
	+		return reinterpret_cast<T*>(e);
	+	}
	+};

	-dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
	+dev_err(dev, "error %pe: %pV", (void*)ERR_PTR(err), &vaf);

---------------------------------------------------------------------
* casts between function and void*

reinterpret_cast left and right (?)

-----------------------------------------------------------------------
* "char*" vs "unsigned char*" vs "signed char*"

C++ tightens rules about pointers to 3 chars, they require casts.
Naturally C code is full of implicit casts between them.

The problem should be easier to solve nowadays given that -funsigned-char
has been merged:

mandate that "raw buffers" are passed as "void*"
mandate that "C strings" are passed as "const char*/char*" or "char buf[]"
do s/unsigned char/char/g

This will make backporters unhappy unless they do -funsigned-char too.
-----------------------------------------------------------------------
* _Generic is not a thing

Rewrite with overloading (easy). Preserving constness is in vogue these days.

	-#define page_slab(p)		(_Generic((p),				\
	-	const struct page *:	(const struct slab *)(p),		\
	-	struct page *:		(struct slab *)(p)))
	+inline const slab* page_slab(const page* page)
	+{
	+	return (const slab*)page;
	+}
	+inline slab* page_slab(page* page)
	+{
	+	return (slab*)page;
	+}

* __builtin_choose_expr is not a thing

Rewrite with templates, return type deductions, overloading etc
Can be fun:

	-#define __inttype(x) __typeof__(		\
	-	__typefits(x,char,			\
	-	  __typefits(x,short,			\
	-	    __typefits(x,int,			\
	-	      __typefits(x,long,0ULL)))))
	-
	-#define __typefits(x,type,not) \
	-	__builtin_choose_expr(sizeof(x)<=sizeof(type),(unsigned type)0,not)
	+template<typename T>
	+constexpr
	+auto
	+__inttype()
	+{
	+	if constexpr (sizeof(T) <= sizeof(char)) {
	+		return static_cast<unsigned char>(0);
	+	} else if constexpr (sizeof(T) <= sizeof(short)) {
	+		return static_cast<unsigned short>(0);
		...
-----------------------------------------------------------------------
* forward declarations

	static struct S s;
	static struct S s = {};

doesn't work (One Definition Rule aka ODR).

It is annoying because struct is often initialised with C99 which must be
reordered too (see below) which creates ordering between 2 patches

I'm doing 

	-static struct S s;
	-extern struct S s;

	-static struct S s = {};
	+struct S s = {};

which is prorably wrong (and make name global for no reason).

Some forward declarations of this type are unnecessary and can be removed
in C Linux.

-----------------------------------------------------------------------
* enum E vs int

rules are stricter, there are a lot of warnings when assigning ints and enums
back and forth, passing them as arguments.

Some types can be changed so that everything matches:

	-	int ret;
	+	enum lru_status ret;

Some enum can be promoted to shut up warnings:

	-	return vmstat_text[NR_VM_ZONE_STAT_ITEMS + item];
	+	return vmstat_text[+NR_VM_ZONE_STAT_ITEMS + item];

Some enums are to be made "inline constexpr" thingies so that
"void __iomem* + int" works in device drivers:

	-enum {
	-	SWITCHTEC_GAS_MRPC_OFFSET       = 0x0000,
	-	SWITCHTEC_GAS_TOP_CFG_OFFSET    = 0x1000,

	+__inline constexpr auto SWITCHTEC_GAS_MRPC_OFFSET       = 0x0000;
	+__inline constexpr auto SWITCHTEC_GAS_TOP_CFG_OFFSET    = 0x1000;

In general enums are big nuisance, because being so weakly typed
C programmers naturally make a mess of them.

-----------------------------------------------------------------------
* offsetof doesn't work for non-constant expressions:

	-	buf = kzalloc_node(offsetof(struct bts_buffer, buf[nbuf]), GFP_KERNEL, node);
	+	buf = kzalloc_node(xoffsetof(struct bts_buffer, buf[nbuf]), GFP_KERNEL, node);

container_of() too. This propagates into list macros, it is not clear what to do.

-----------------------------------------------------------------------
* address of rvalue

passing anon instances into functions doesn't work:

	-	return file_open_root(&(struct path){.mnt = mnt, .dentry = mnt->mnt_root}, name, flags, mode);
	+	auto p = path{.mnt = mnt, .dentry = mnt->mnt_root};
	+	return file_open_root(&p, name, flags, mode);

-----------------------------------------------------------------------
* struct_group_tagged doesn't work

It generates errors/warnings because initialisations.

I don't even want to look at it again.

	-	struct_group_tagged(sk_buff_list, list,
	-		struct sk_buff	*next;
	-		struct sk_buff	*prev;
	-	);
	+	struct sk_buff	*next;
	+	struct sk_buff	*prev;

All this struct mangling is very painful because current init rules for C++ are stricter.

This won't fly, because security will degrade.
----------------------------------------------------------------------
* gcc plugins don't work

something segfaults, mark as BROKEN ofc.
----------------------------------------------------------------------
* flexible array members

g++ sometimes doesn't like what we're doing:

	-	unsigned char	__data[];
	+	unsigned char	__data[0];

Whoever is deleting zeroes will be upset.
--------------------------------------------------------------
* g++ rules for C99 initialisers are stricter than gcc's

This is https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113124

To reiterate:

	initilizers must be in struct declaration order,
	missing middle initializer is an error

	missing array element initializer is an error
	reordering array element initializers is an error
	even if whole array is initialized

This is very painful restriction: see skl_hw_cache_extra_regs[]

It can be workarounded with lambdas:

	-const struct super_operations shmem_ops = {
	-	.alloc_inode	= shmem_alloc_inode,
	-	.destroy_inode	= shmem_destroy_inode,
	-	.free_inode	= shmem_free_in_core_inode,
	+const struct super_operations shmem_ops = [](){
	+	struct super_operations _{};
	+	_.alloc_inode	= shmem_alloc_inode;
	+	_.destroy_inode	= shmem_destroy_inode;
	+	_.free_inode	= shmem_free_in_core_inode;

		...

	-static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
	-	{ [ 0 ... XFEATURE_MAX - 1] = -1};
	+static auto xstate_offsets __ro_after_init = [](){
	+	array<unsigned int, XFEATURE_MAX> _{};
	+	for (auto& _: _) {
	+		_ = -1;
	+	}
	+	return _;
	+}();

This is strictly more powerful than what C can do. It looks funny,
but once you get used to it, it looks natural.

I can convert these things blindfolded by now.

--------------------------------------------------------------
* consteval

There is a problem with lambda initialization (let's call it this way)

If g++ can't do everything at compile time, then it will generate
runtime init code.

In fact first fcouple of oopses of glorious Linux++ project were of
such type: struct gets all pointer to function NULL and nothing works.

In my defence, third oops was "int/long" confusion in ERR_PTR
and... that's it... there were no oopses afterwards, Linux++ survived LTP!

Therefore it is imperative to detect runtime init by looking at vmlinux and
ban such init until it is made official (how exactly). At the moment of
conversion _everything_ must be init at compile time because everything
is C code really.

consteval is such guarantee

BUT!

"consteval" is orthogonal from "const"!

I don't want to be the one asking C programmers to type "const consteval"... 


--------------------------------------------------------------
* struct declaration inside struct declaration

	struct S {
		struct X {
		} x;
	};

doesn't work, requires moving X to the top level.

Minor nuisance, source compatible with C.

---------------------------------------------------------
* wpa

g++ has -Wno-pointer-arith however "void* - void*" doesn't work.

Solution -- cast to "char*"

	-	offset = buf - head;
	+	offset = (char *)buf - (char *)head;

Ideally g++ won't warn about these as well.

----------------------------------------------------------
* extern "C" {}

aliased functions (which all module_init/module_exit/...) hooks are
must be extern "C" because there is no way to construct correct string
literal at compile time.

	+extern "C" {
	 static int __init cgroup1_wq_init(void)
	 }
	+}
	 core_initcall(cgroup1_wq_init);

Everything called from assembly naturally has to be extern "C"
(or rewritten to the mangled name which is unreadable).

-----------------------------------------------------------
* inline

Rules for "inline" are different!

First, "static inline" function which address is taken of
will _not_ be emitted out of line resulting in link error.

Second, our inline keyword is a macro, so "inline constexpr"
has to be written as "__inline constexpr" until "inline"
is sorted out.

=================================================================


Now let's see what C++ can offer:



* alignas

C++ puts alignas where you don't expect it (unless you wrote a C/C++ compiler):

	struct alignas(A) S {};

This will upset people who like to "grep -e 'struct S {'".
They have to be told to either install indexing tool and bugger off. :-(

Furtunately, C added _Alignas so it won't look _that_ alien:

	-	u8 data[] __aligned(8);
	+	alignas(8) u8 data[];

There little problem is that alignas() has to be BEFORE "static"

	alignas(A)
	static const char x[...];

so you can't reuse some clever macro

	static DEFINE_ALIGNED_STUFF(x)

Very unfortunate, hopefully number of such cases is very small.


--------------------------

* alignof

alignof is reserved keyword

	s/__alignof__/alignof/g

after converting to alignas() because __attribute__((aligned(__alignof__(T))))

------------------------------------

* auto

auto is cool

	template<typename T>
	auto f()
	{
		if constexpr (...) {
			return T1();
		} else if constexpr (...) {
			return T2();
		}

is cool too.

"const auto&" and "auto&&" are cool too.

People sneaked in few "__auto_type" instances already.

----------------------------------------------
* type_traits

Large part of <type_traits> should be imported/rewritten
for Linux Standard Library. Good part is that we can reorder stuff
small headers to save on parsing and implement what's necessary,
not the whole shebang.

Use them in templates, left, right and center.

---------------------------------------------
* function overloading

it is cool if standard library is kept well maintained

I can imagine

	struct S* obj = lalloc<S>(GFP_KERNEL);
	struct S* obj = lalloc<S>(GFP_KERNEL, numa_node);

and even

	struct S* obj_array = lalloc<S>(GFP_KERNEL, n1);

for array allocations.

Lots of taste should go in designing overload sets.

Easy stuff is kabs(), kdiv(), min/max, etc

	+template<typename T, typename... Ts>
	+constexpr
	+T
	+min(T a, T b, Ts... etc)
	+{
	+	static_assert((is_same_v<T, Ts> && ...));
	+
	+	if constexpr (sizeof...(Ts) == 0) {
	+		return (a < b) ? a : b;
	+	} else {
	+		return min(min(a, b), etc...);
	+	}
	+}

* destructuring with returning structs/tuples from a function

	auto&& [a, b] = f();

this should be better codegen wise because returning 2 values from a function
in registers is apparently a thing in ABIs (rax:rdx) but it is unergonomic
to do it in C. You have to invent a typename for each function.

--------------------------------------------------------------

* type safe enums

C++ world is filled with such libraries. Needless to say we'll discard
all of them of course and write our own:

	+#include <c++/enum.h>
	@@ -203,6 +204,7 @@ enum dma_ctrl_flags {
	 	DMA_PREP_REPEAT = (1 << 8),
	 	DMA_PREP_LOAD_EOT = (1 << 9),
	 };
	+ENUM_FLAGS(enum dma_ctrl_flags)

	+#define ENUM_FLAGS(E)			\
	+constexpr				\
	+E					\
	+operator&(E a, E b)			\
	+{					\
	+	using UT = __underlying_type(E);\
	+	return (E)(UT(a) & UT(b));	\
	+}					\
	+					\
	+constexpr				\
	+E&					\
	+operator&=(E& a, E b)			\
	+{					\
	+	return a = a & b;		\
	+}

You get the idea.

For printing the plan is to overload unary + operator and cast it
to the underlying type, so that printing is minimally abusive
to the programmer:

	-printk("e %d\n", e);
	+printk("e %d\n", +e);

The companion macros are ENUM_INC/ENUM_DEC:

	+ENUM_INC(enum bpf_xdp_mode)

	+#define ENUM_INC(E)			\
	+constexpr				\
	+E&					\
	+operator++(E& e)			\
	+{					\
	+	using UT = __underlying_type(E);\
	+	return e = (E)(UT(e) + UT(1));	\
	+}

-----------------------------------------------------------
* templates

templates are good when used where necessary

kfifo is good example of Greg reinventing templates

I don't a proper patch but include/linux/kfifo.h is prime testing
ground.

----------------------------------------------------------
* attributes

[[maybe_unused]], [[nodiscard]], [[noreturn]]
are standard attributes, not of these self grown macros (with 2 underscores each)

__why__ __underscores? _is there__ __some__ sec__ret _underscore_society_?

---------------------------------------------------
* better type checking

cpu_t, numa_node_t, jiffies_t,
phys_addr_t, bus_addr_t, hypervisor types,
pfn_t, maybe even shifts

rcu_ptr<>, user_ptr<>, iomem_ptr<>

all sort of flags (this minor actually, people don't really make such bugs)
---------------------------------------------------
* custom type printing

this <fmt> library or equivalent.

%p hack looks like genius move to a C programmer. But it is facepalm
to a C++ programmer.

Until some compile time checked printk() exists
unary + can be overloaded to minimise typing

	cpu_t cpu = ...;
	printk("cpu%d\n", +cpu);

============================================================

What I think is Linux++ MVP


* casts, C99 structs, C99 arrays, keywords

* small stuff templatised: min(), max(), ...

I don't particularly care about SFINAE/concepts. I think static_assert
is enough. static_assert() gives file:line and this is enough.

* unique_ptr<T, D>

this allows to delete goto-on-error-path and delete
include/linux/cleanup.h / __attribute__((cleanup))

devm_ is reinvention of unique_ptr for subset of types

Preprocess and import from STL after cutting all the crap.

* RAII stuff

it looks unnatural to read

	{
		auto _ = std::lock_guard{g_mutex};
		...
		return 0;
	}

I still shudder every time. But that's what userspace C++ dudes and
dudettes are told to do. Maybe it is not _that_ bad.


#pragma once
#include <linux/mutex.h>

// FIXME break inside loop will break out of the wrong loop
#define with_mutex(m)	\
	for (mutex_raii _{m}, *__ = (mutex_raii*)1; __; __ = nullptr)

class raii_mutex {
	mutex& obj;

public:
	explicit
	raii_mutex(mutex& obj)
		: obj{obj}
	{
		mutex_lock(&obj);
	}

	~raii_mutex()
	{
		mutex_unlock(&obj);
	}

	raii_mutex(const raii_mutex&) = delete;
	raii_mutex& operator=(const raii_mutex&) = delete;
};

with_rcu/with_mutex/with_spinlock/ loops are beartrapish because of "break;"
I like the name best, but it adds 1 indent level which with 8 spaces adds up
quickly. Maybe not do with_mutex().

* std::array, std::span equivalent

I dont' have span but it looks useful enough. [[wikipedia::citation_needed]]

I have std::array, though

	template<typename T, size_t D1, size_t D2>
	using array2 = array<array<T, D2>, D1>;

	template<typename T, size_t D1, size_t D2, size_t D3>
	using array3 = array<array<array<T, D3>, D2>, D1>;

* -fno-exceptions -fno-rtti

it is natural to ban exceptions at the point of conversion.
C code is -fno-exceptions after all.

You guys discussing exceptions are too far ahead, you don't even probably
realise how early is to discuss exceptions.

	 KBUILD_CFLAGS :=
	-KBUILD_CFLAGS += -std=gnu11
	+KBUILD_CFLAGS += -std=gnu++23
	 KBUILD_CFLAGS += -fshort-wchar
	 KBUILD_CFLAGS += -funsigned-char
	+KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
	 KBUILD_CFLAGS += -fno-common
	+KBUILD_CFLAGS += -fno-exceptions
	 KBUILD_CFLAGS += -fno-PIE
	+KBUILD_CFLAGS += -fno-rtti
	 KBUILD_CFLAGS += -fno-strict-aliasing
	+KBUILD_CFLAGS += -fno-unwind-tables

Other non-problems include: what is allowed, what's not (inheritance,
virtual, what else is boogie man these days)

Right now, due to sheer volume of the code I'm working on automatic converter
for casts, wpa and C99 stuff. At the rate I'm going it should be ready by 2040.

Bulk autoconversion is very important because rebasing allmodconfig-like
configs is way too much.

	Alexey++

P.S.:

	$ sudo cat /proc/$(pidof -s sshd)/stack
	[<0>] _ZL9do_selectiP11fd_set_bitsP10timespec64+0x657/0x7b0
	[<0>] _Z15core_sys_selectiP15__kernel_fd_setS0_S0_P10timespec64+0x16e/0x3b0
	[<0>] _Z16__x64_sys_selectPK7pt_regs+0xe8/0x150
	[<0>] do_syscall_64+0x41/0xe0
	[<0>] entry_SYSCALL_64_after_hwframe+0x46/0x4e

	$ git-diff master..linux++-001 | diffstat -p1
	 5376 files changed, 46871 insertions(+), 45189 deletions(-)

That's one small .config for testing plus a little here and there.

